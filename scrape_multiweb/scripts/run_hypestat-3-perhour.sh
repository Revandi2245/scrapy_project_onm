#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_hypestat-3-perhour started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=gridoto -a path=fixtures_hypestat/gridoto_config.json
scrapy crawl generic_spider -a spider_name=motortrader -a path=fixtures_hypestat/motortrader_config.json
scrapy crawl generic_spider -a spider_name=mototrend -a path=fixtures_hypestat/mototrend_config.json
scrapy crawl generic_spider -a spider_name=otospeed -a path=fixtures_hypestat/otospeed_config.json
scrapy crawl generic_spider -a spider_name=otosportif -a path=fixtures_hypestat/otosportif_config.json
scrapy crawl generic_spider -a spider_name=ototrend -a path=fixtures_hypestat/ototrend_config.json
scrapy crawl generic_spider -a spider_name=pitlanemag -a path=fixtures_hypestat/pitlanemag_config.json
scrapy crawl generic_spider -a spider_name=viva -a path=fixtures_hypestat/viva_config.json
scrapy crawl generic_spider -a spider_name=zigwheels -a path=fixtures_hypestat/zigwheels_config.json
scrapy crawl generic_spider -a spider_name=ototaiment -a path=fixtures_hypestat/ototaiment_config.json


wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_hypestat-3-perhour Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_hypestat-3-perhour selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi hypestat-3-perhour: ${ELAPSED_TIME} detik" >> logs/debug.log