#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_generic_spider_olx-4 started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=kelaster -a path=fixtures_olx/kelaster_config.json
scrapy crawl generic_spider -a spider_name=lensautama -a path=fixtures_olx/lensautama_config.json
scrapy crawl generic_spider -a spider_name=makassarchannel -a path=fixtures_olx/makassarchannel_config.json
scrapy crawl generic_spider -a spider_name=moveroad -a path=fixtures_olx/moveroad_config.json
scrapy crawl generic_spider -a spider_name=nevbuzz -a path=fixtures_olx/nevbuzz_config.json

scrapy crawl generic_spider -a spider_name=potretbikers -a path=fixtures_olx/potretbikers_onfig.json
scrapy crawl generic_spider -a spider_name=parapat -a path=fixtures_olx/parapat_config.json
scrapy crawl generic_spider -a spider_name=radarjakarta -a path=fixtures_olx/radarjakarta_config.json
scrapy crawl generic_spider -a spider_name=regukabar -a path=fixtures_olx/regukabar_config.json
scrapy crawl generic_spider -a spider_name=sangkala -a path=fixtures_olx/sangkala_config.json

scrapy crawl generic_spider -a spider_name=the8news -a path=fixtures_olx/the8news_config.json
scrapy crawl generic_spider -a spider_name=tikta -a path=fixtures_olx/tikta_config.json


wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_generic_spider_olx-4 Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_generic_spider_olx-4 selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi generic_spider_olx-4: ${ELAPSED_TIME} detik" >> logs/debug.log