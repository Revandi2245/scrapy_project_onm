#!/bin/bash
cd "$(dirname "$0")/.."

echo "$(date): run_all.sh started" >> logs/debug.log

# aktifkan venv jika perlu
# source /home/revandi2245/scraper_project/venv/bin/activate

scrapy crawl generic_spider -a spider_name=metrotvnews -a path=fixtures/spider_config.json  &
scrapy crawl generic_spider -a spider_name=satumedia -a path=fixtures/spider_config.json &
scrapy crawl generic_spider -a spider_name=pomodo -a path=fixtures/spider_config.json &
scrapy crawl generic_spider -a spider_name=poultryindonesia -a path=fixtures/spider_config.json &
scrapy crawl generic_spider -a spider_name=seru -a path=fixtures/spider_config.json &
scrapy crawl generic_spider -a spider_name=kabarbaik -a path=fixtures/spider_config.json &
scrapy crawl generic_spider -a spider_name=postingnews -a path=fixtures/spider_config.json &

wait
