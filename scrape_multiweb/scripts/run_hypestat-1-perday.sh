#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_hypestat-1-perday started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=viwimoto -a path=fixtures_hypestat/viwimoto_config.json
scrapy crawl generic_spider -a spider_name=infodigital -a path=fixtures_hypestat/infodigital_config.json
scrapy crawl generic_spider -a spider_name=autofun -a path=fixtures_hypestat/autofun_config.json
scrapy crawl generic_spider -a spider_name=automotivedive -a path=fixtures_hypestat/automotivedive_config.json
scrapy crawl generic_spider -a spider_name=autonesian -a path=fixtures_hypestat/autonesian_config.json
scrapy crawl generic_spider -a spider_name=sportcorner -a path=fixtures_hypestat/sportcorner_config.json
scrapy crawl generic_spider -a spider_name=beritatransparansi -a path=fixtures_hypestat/beritatransparansi_config.json


wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_hypestat-1-perday Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_hypestat-1-perday selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi hypestat-1-perday: ${ELAPSED_TIME} detik" >> logs/debug.log