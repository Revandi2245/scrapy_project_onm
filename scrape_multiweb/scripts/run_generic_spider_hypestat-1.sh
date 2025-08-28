#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_generic_spider_hypestat-1 started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=otomampir -a path=fixtures_hypestat/otomampir_config.json
scrapy crawl generic_spider -a spider_name=otodetik -a path=fixtures_hypestat/otodetik_config.json
scrapy crawl generic_spider -a spider_name=beritaotomotif -a path=fixtures_hypestat/beritaotomotif_config.json
scrapy crawl generic_spider -a spider_name=duniascooter -a path=fixtures_hypestat/duniascooter_semaraknews_config.json
scrapy crawl generic_spider -a spider_name=semaraknews -a path=fixtures_hypestat/semaraknews_config.json

scrapy crawl generic_spider -a spider_name=jakmotor -a path=fixtures_hypestat/jakmotor_config.json
scrapy crawl generic_spider -a spider_name=beritaapm -a path=fixtures_hypestat/beritaapm_config.json
scrapy crawl generic_spider -a spider_name=merdekaoto -a path=fixtures_hypestat/merdekaoto_config.json


wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_generic_spider_hypestat-1 Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_generic_spider_hypestat-1 selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi hypestat-1-perhour: ${ELAPSED_TIME} detik" >> logs/debug.log