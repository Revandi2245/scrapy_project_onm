#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=canggih \
  -a path=fixtures_olx/canggih_config.json \
  -o output/canggih.json