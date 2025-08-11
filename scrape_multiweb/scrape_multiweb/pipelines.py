# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
import psycopg2
import json
from kafka import KafkaProducer
from dotenv import load_dotenv
import os
load_dotenv()

class KafkaPipeline:
    def __init__(self):
        self.topic = os.getenv("TOPIC_NAME")
        bootstrap_servers = os.getenv("BOOTSTRAP_SERVERS", "")
        self.producer = KafkaProducer(
            bootstrap_servers=bootstrap_servers.split(","),
            value_serializer=lambda v: json.dumps(v).encode('utf-8')
        )

    def process_item(self, item, spider):
        try:
            self.producer.send(self.topic, dict(item))
            spider.logger.info(f"[Kafka] Berhasil kirim: {item['link']}")
        except Exception as e:
            spider.logger.warning(f"[Kafka] Gagal kirim data: {e}")
        return item

    def close_spider(self, spider):
        spider.logger.info("[Kafka] Flushing & closing producer...")
        self.producer.flush()
        self.producer.close()


class PostgresURLPipeline:

    def __init__(self):
        ## Connection Details
        hostname = os.getenv("DB_HOST")
        username = os.getenv("DB_USERNAME")
        password = os.getenv("DB_PASSWORD")
        database = os.getenv("DB_DATABASE")
        port = os.getenv("DB_PORT")

        ## Create/Connect to database 
        self.connection = psycopg2.connect(
            host=hostname,
            dbname=database,
            user=username,
            password=password,
            port=port
        )

        ## Create cursor, used to execute commands
        self.cur = self.connection.cursor()

        ## Create quotes table if none exists
        self.cur.execute("""
            CREATE TABLE IF NOT EXISTS scraped_urls (
                id SERIAL PRIMARY KEY,
                url TEXT UNIQUE,
                domain TEXT
            )
        """)
        self.connection.commit()

    def close_spider(self, spider):
        self.connection.commit()
        self.cur.close()
        self.connection.close()

    def process_item(self, item, spider):
        try:
            self.cur.execute(
                "INSERT INTO scraped_urls (url, domain) VALUES (%s, %s) ON CONFLICT (url) DO NOTHING",
                (item["url"], item["domain"])
            )
        except Exception as e:
            spider.logger.warning(f"[DB] Gagal simpan URL: {item.get('url')} | Error: {e}")
        return item

