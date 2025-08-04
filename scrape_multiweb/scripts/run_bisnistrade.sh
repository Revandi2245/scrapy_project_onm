#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=bisnistrade \
  -a path=fixtures/bisnistrade_config.json \
    -o output/bisnistrade.json