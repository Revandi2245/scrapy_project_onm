from kafka import KafkaConsumer
import psycopg2
import json
import os
from dotenv import load_dotenv
load_dotenv()

consumer = KafkaConsumer(
    'scraped_urls_topic',
    bootstrap_servers=os.getenv("BOOTSTRAP_SERVERS"),
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='scrape-group',
    value_deserializer=lambda x: json.loads(x.decode('utf-8'))
)

conn = psycopg2.connect(
    dbname=os.getenv("DB_DAtABASE"),
    user=os.getenv("DB_USERNAME"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)
cur = conn.cursor()

print("Consumer berjalan dan menunggu pesan...")

for message in consumer:
    item = message.value
    print(f"[Kafka → DB] Menerima item: {item['url']}")
    try:
        cur.execute(
            "INSERT INTO scraped_urls (url, domain) VALUES (%s, %s) ON CONFLICT (url) DO NOTHING",
            (item['url'], item['domain'])
        )
        conn.commit()
        print(f"[DB] Tersimpan: {item['url']}")
    except Exception as e:
        print(f"[DB] Gagal simpan: {e}")
