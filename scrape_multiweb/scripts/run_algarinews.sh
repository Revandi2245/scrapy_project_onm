#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=algarinews \
  -a path=fixtures_olx/algarinews_config.json \
  -o output/algarinews.json