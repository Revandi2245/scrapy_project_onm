#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=rockotomotif \
  -a path=fixtures/rockotomotif_config.json \
  -o output/rockotomotif.json