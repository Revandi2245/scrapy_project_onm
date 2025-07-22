import os
import psycopg2
from dotenv import load_dotenv
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings
from scrape_multiweb.spiders.detik_spider import DetikSpiderSpider
from scrape_multiweb.spiders.bisnis_spider import BisnisSpiderSpider
from scrape_multiweb.spiders.kompas_spider import KompasSpiderSpider

load_dotenv()
def get_urls_from_db():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        dbname=os.getenv("DB_DATABASE"),
        user=os.getenv("DB_USERNAME"),
        password=os.getenv("DB_PASSWORD"),
        port=os.getenv("DB_PORT", "5432")
    )

    #Setting auto commit false
    conn.autocommit = True

    #Creating a cursor object using the cursor() method
    cursor = conn.cursor()

    #Retrieving data
    cursor.execute("SELECT url FROM scraped_urls")
    urls = [row[0] for row in cursor.fetchall()]
    conn.close()
    return urls


if __name__ == "__main__":
    urls = get_urls_from_db()
    print(f"Total URL to process: {len(urls)}")

    settings = get_project_settings()
    settings.set('FEEDS', {
        'content_spider.json': {
            'format': 'json',
            'encoding': 'utf8',
            'store_empty': False,
            'fields': None,
            'indent': 4,
        },
    })

    process = CrawlerProcess(settings)
    process.crawl(DetikSpiderSpider, start_urls=urls)
    process.crawl(BisnisSpiderSpider, start_urls=urls)
    process.crawl(KompasSpiderSpider, start_urls=urls)
    process.start()
