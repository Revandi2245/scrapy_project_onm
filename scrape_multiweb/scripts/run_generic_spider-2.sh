#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs
echo "$(date): run_generic_spider-2 started" >> logs/debug.log

if [ -d "/home/revandi2245/scraper_project/venv" ]; then
    source /home/revandi2245/scraper_project/venv/bin/activate
elif [ -d "/root/interns-2025/scrapy_project_onm/venv" ]; then
    source /root/interns-2025/scrapy_project_onm/venv/bin/activate
elif [ -d "$(dirname "$0")/../venv" ]; then
    source "$(dirname "$0")/../venv/bin/activate"
else
    echo "Virtual environment tidak ditemukan!"
    exit 1
fi

scrapy crawl generic_spider -a spider_name=ekonosia -a path=fixtures/ekonosia_config.json &
scrapy crawl generic_spider -a spider_name=malang-post -a path=fixtures/malangpost_config.json &
scrapy crawl generic_spider -a spider_name=malangposcomedia -a path=fixtures/malangposcomedia_config.json &
scrapy crawl generic_spider -a spider_name=portaldesa -a path=fixtures/portaldesa_config.json &
scrapy crawl generic_spider -a spider_name=qoo10 -a path=fixtures/qoo10_config.json &

wait
