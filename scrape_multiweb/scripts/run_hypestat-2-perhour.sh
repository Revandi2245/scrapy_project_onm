#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_hypestat-2-perhour started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=autogear -a path=fixtures_hypestat/autogear_config.json
scrapy crawl generic_spider -a spider_name=autoglobemagz -a path=fixtures_hypestat/autoglobemagz_config.json
scrapy crawl generic_spider -a spider_name=autos -a path=fixtures_hypestat/autos_config.json
scrapy crawl generic_spider -a spider_name=baliportalnews -a path=fixtures_hypestat/baliportalnews_config.json
scrapy crawl generic_spider -a spider_name=bareksa -a path=fixtures_hypestat/bareksa_config.json
scrapy crawl generic_spider -a spider_name=beritajatim -a path=fixtures_hypestat/beritajatim_config.json
scrapy crawl generic_spider -a spider_name=hotcars -a path=fixtures_hypestat/hotcars_config.json
scrapy crawl generic_spider -a spider_name=kontan -a path=fixtures_hypestat/kontan_config.json
# scrapy crawl generic_spider -a spider_name=idnfinancials -a path=fixtures_hypestat/idnfinancials_config.json
scrapy crawl generic_spider -a spider_name=indoride -a path=fixtures_hypestat/indoride_config.json
scrapy crawl generic_spider -a spider_name=otohub -a path=fixtures_hypestat/otohub_config.json
scrapy crawl generic_spider -a spider_name=topspeed -a path=fixtures_hypestat/topspeed_config.json


wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_hypestat-2-perhour Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_hypestat-2-perhour selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi hypestat-2-perhour: ${ELAPSED_TIME} detik" >> logs/debug.log