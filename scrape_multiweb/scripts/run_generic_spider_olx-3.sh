#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_generic_spider_olx-3 started" >> logs/debug.log

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

# scrapy crawl generic_spider -a spider_name=andreaautopage -a path=fixtures_olx/andreaautopage_config.json -o output/andreaautopage.json
scrapy crawl generic_spider -a spider_name=autoindo -a path=fixtures_olx/autoindo_config.json
scrapy crawl generic_spider -a spider_name=iotomagz -a path=fixtures_olx/iotomagz_config.json
scrapy crawl generic_spider -a spider_name=selular -a path=fixtures/selular_config.json
scrapy crawl generic_spider -a spider_name=lomboksultan -a path=fixtures_olx/lomboksultan_config.json
# scrapy crawl generic_spider -a spider_name=mounture -a path=fixtures/mounture_config.json -o output/mounture.json
scrapy crawl generic_spider -a spider_name=pojokoto -a path=fixtures_olx/pojokoto_config.json
scrapy crawl generic_spider -a spider_name=rockomotif -a path=fixtures_olx/rockomotif_config.json
scrapy crawl generic_spider -a spider_name=spiritnesia -a path=fixtures_olx/spiritnesia_config.json 
scrapy crawl generic_spider -a spider_name=tabloidpulsa -a path=fixtures_olx/tabloidpulsa_config.json
scrapy crawl generic_spider -a spider_name=bindo -a path=fixtures_olx/bindo_config.json -o
scrapy crawl generic_spider -a spider_name=beritakota -a path=fixtures_olx/beritakota_config.json

scrapy crawl generic_spider -a spider_name=extranews -a path=fixtures_olx/extranews_config.json
scrapy crawl generic_spider -a spider_name=gardaberita -a path=fixtures_olx/gardaberita_config.json
scrapy crawl generic_spider -a spider_name=getpost -a path=fixtures_olx/getpost_config.json
scrapy crawl generic_spider -a spider_name=investor -a path=fixtures_olx/investor_config.json
scrapy crawl generic_spider -a spider_name=jakartahighlight -a path=fixtures_olx/jakartahighlight_config.json
scrapy crawl generic_spider -a spider_name=jurnalbikers -a path=fixtures_olx/jurnalbikers_config.json


wait



EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_generic_spider_olx-3 Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_generic_spider_olx-3 selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi generic_spider_olx-3: ${ELAPSED_TIME} detik" >> logs/debug.log