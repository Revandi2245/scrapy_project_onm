#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs
echo "$(date): run_generic_spider_olx-1 started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=hargo -a path=fixtures/hargo_config.json &
scrapy crawl generic_spider -a spider_name=hotnews -a path=fixtures/hotnews_config.json &
scrapy crawl generic_spider -a spider_name=jakartaglobe -a path=fixtures/jakartaglobe_config.json -o output/jakartaglobe.json &
scrapy crawl generic_spider -a spider_name=karyaredaksi -a path=fixtures/karyaredaksi_config.json &
scrapy crawl generic_spider -a spider_name=marketing -a path=fixtures/marketing_config.json &
scrapy crawl generic_spider -a spider_name=pelitabatak -a path=fixtures/pelitabatak_config.json &
scrapy crawl generic_spider -a spider_name=otobisnis -a path=fixtures/otobisnis_config.json &
scrapy crawl generic_spider -a spider_name=rajabalapotomotif -a path=fixtures/rajabalapotomotif_config.json &
scrapy crawl generic_spider -a spider_name=wartapol -a path=fixtures/wartapol_config.json &
scrapy crawl generic_spider -a spider_name=vritta -a path=fixtures/vritta_config.json &
scrapy crawl generic_spider -a spider_name=allrelease -a path=fixtures/allrelease_config.json -o output/allrelease.json &
scrapy crawl generic_spider -a spider_name=bisnistrade -a path=fixtures/bisnistrade_config.json &
scrapy crawl generic_spider -a spider_name=pojokindonesia -a path=fixtures/pojokindonesia_config.json &
scrapy crawl generic_spider -a spider_name=selular -a path=fixtures/selular_config.json -o output/selular.json &
scrapy crawl generic_spider -a spider_name=sonaindonesia -a path=fixtures/sonaindonesia_config.json &

wait
