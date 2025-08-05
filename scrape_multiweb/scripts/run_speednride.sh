#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=speednride \
  -a path=fixtures/speednride_config.json \
  -o output/speednride.json