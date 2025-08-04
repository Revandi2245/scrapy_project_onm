#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=marketing \
  -a path=fixtures/marketing_config.json \
  -o output/marketing.json