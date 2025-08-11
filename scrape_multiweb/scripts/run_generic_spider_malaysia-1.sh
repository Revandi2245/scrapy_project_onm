#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_generic_spider_malaysia-1 started" >> logs/debug.log

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

scrapy crawl generic_spider -a spider_name=aliran -a path=fixtures_malaysia/aliran_config.json -o output/aliran.json
# scrapy crawl generic_spider -a spider_name=malaysiakini -a path=fixtures_malaysia/malaysiakini_config.json -o output/malaysiakini.json
scrapy crawl generic_spider -a spider_name=malaymail -a path=fixtures_malaysia/malaymail_config.json -o output/malaymail.json
scrapy crawl generic_spider -a spider_name=cna -a path=fixtures_malaysia/cna_config.json -o output/cna.json
scrapy crawl generic_spider -a spider_name=malaysiagazette -a path=fixtures_malaysia/malaysiagazette_config.json -o output/malaysiagazette.json

scrapy crawl generic_spider -a spider_name=freemalaysiatoday -a path=fixtures_malaysia/freemalaysiatoday_config.json -o output/freemalaysiatoday.json
scrapy crawl generic_spider -a spider_name=freemalaysianews -a path=fixtures_malaysia/freemalaysianews_config.json -o output/freemalaysianews.json
scrapy crawl generic_spider -a spider_name=harianmetro -a path=fixtures_malaysia/harianmetro_config.json -o output/harianmetro.json
scrapy crawl generic_spider -a spider_name=therakyatpost -a path=fixtures_malaysia/therakyatpost_config.json -o output/therakyatpost.json
scrapy crawl generic_spider -a spider_name=bernama -a path=fixtures_malaysia/bernama_config.json -o output/bernama.json
scrapy crawl generic_spider -a spider_name=mothershipsg -a path=fixtures_malaysia/mothershipsg_config.json -o output/mothershipsg.json

scrapy crawl generic_spider -a spider_name=edgeprop -a path=fixtures_malaysia/edgeprop_config.json -o output/edgeprop.json
scrapy crawl generic_spider -a spider_name=thestar -a path=fixtures_malaysia/thestar_config.json -o output/thestar.json
scrapy crawl generic_spider -a spider_name=mindanews -a path=fixtures_malaysia/mindanews_config.json -o output/mindanews.json
scrapy crawl generic_spider -a spider_name=mysinchew -a path=fixtures_malaysia/mysinchew_config.json -o output/mysinchew.json
scrapy crawl generic_spider -a spider_name=sinarharian -a path=fixtures_malaysia/sinarharian_config.json -o output/sinarharian.json
scrapy crawl generic_spider -a spider_name=asiatimes -a path=fixtures_malaysia/asiatimes_config.json -o output/asiatimes.json
scrapy crawl generic_spider -a spider_name=malaysiabusiness -a path=fixtures_malaysia/malaysiabusiness_config.json -o output/malaysiabusiness.json
scrapy crawl generic_spider -a spider_name=theedgemalaysia -a path=fixtures_malaysia/theedgemalaysia_config.json -o output/theedgemalaysia.json





wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_generic_spider_malaysia-1 Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_generic_spider_malaysia-1 selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi run_generic_spider_malaysia-1: ${ELAPSED_TIME} detik" >> logs/debug.log