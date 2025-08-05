#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=mobitekno \
  -a path=fixtures_olx/mobitekno_config.json \
  -o output/mobitekno.json