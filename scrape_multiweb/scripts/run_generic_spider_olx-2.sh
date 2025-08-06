#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_generic_spider_olx-2 started" >> logs/debug.log

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


scrapy crawl generic_spider -a spider_name=algarinews -a path=fixtures_olx/algarinews_config.json &
# scrapy crawl generic_spider -a spider_name=andreaautopage -a path=fixtures_olx/andreaautopage_config.json -o output/andreaautopage.json &
scrapy crawl generic_spider -a spider_name=apinusantara -a path=fixtures_olx/apinusantara_config.json &
scrapy crawl generic_spider -a spider_name=ayolombok -a path=fixtures_olx/ayolombok_config.json &
scrapy crawl generic_spider -a spider_name=canggih -a path=fixtures_olx/canggih_config.json &
wait

scrapy crawl generic_spider -a spider_name=ciayumajakuning -a path=fixtures_olx/ciayumajakuning_config.json &
scrapy crawl generic_spider -a spider_name=dapurpacu -a path=fixtures_olx/dapurpacu_config.json &
scrapy crawl generic_spider -a spider_name=gerak -a path=fixtures_olx/gerak_config.json &
scrapy crawl generic_spider -a spider_name=alongwalker -a path=fixtures_olx/alongwalker_config.json &
scrapy crawl generic_spider -a spider_name=lajuroda -a path=fixtures_olx/lajuroda_config.json &
wait

scrapy crawl generic_spider -a spider_name=mobitekno -a path=fixtures_olx/mobitekno_config.json &
scrapy crawl generic_spider -a spider_name=otodiva -a path=fixtures_olx/otodiva_config.json &
scrapy crawl generic_spider -a spider_name=sinarharapan -a path=fixtures_olx/sinarharapan_config.json &
# scrapy crawl generic_spider -a spider_name=tabloidputrapos -a path=fixtures_olx/tabloidputrapos_config.json -o output/tabloidputrapos.json &
# scrapy crawl generic_spider -a spider_name=speednride -a path=fixtures_olx/speednride_config.json -o output/speednride.json &
wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_generic_spider_olx-2 Timeout 20 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_generic_spider_olx-2 selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi: ${ELAPSED_TIME} detik" >> logs/debug.log