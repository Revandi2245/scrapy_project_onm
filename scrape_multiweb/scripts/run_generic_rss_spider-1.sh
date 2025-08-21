#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p logs

START_TIME=$(date +%s)
echo "$(date): run_generic_rss_spider-1 started" >> logs/debug.log

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

scrapy crawl generic_rss_spider -a spider_name=cnn_rss -a path=fixtures_rss/config_example.json -o output/cnn_rss.json
scrapy crawl generic_rss_spider -a spider_name=antaranews_rss -a path=fixtures_rss/config_example.json -o output/antaranews_rss.json
scrapy crawl generic_rss_spider -a spider_name=nytimes_rss -a path=fixtures_rss/config_example.json -o output/nytimes_rss.json
scrapy crawl generic_rss_spider -a spider_name=beritaindonesia_rss -a path=fixtures_rss/config_example.json -o output/beritaindonesia_rss.json
scrapy crawl generic_rss_spider -a spider_name=viva_rss -a path=fixtures_rss/config_example.json -o output/viva_rss.json
scrapy crawl generic_rss_spider -a spider_name=sindonews_rss -a path=fixtures_rss/config_example.json -o output/sindonews_rss.json

wait

EXIT_CODE=$?
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

if [ $EXIT_CODE -eq 124 ]; then
    echo "$(date): run_generic_rss_spider-1 Timeout 10 menit tercapai, proses dihentikan otomatis" >> logs/debug.log
else
    echo "$(date): run_generic_rss_spider-1 selesai dengan exit code $EXIT_CODE" >> logs/debug.log
fi

echo "$(date): Total waktu eksekusi run_generic_rss_spider-1: ${ELAPSED_TIME} cnn" >> logs/debug.log