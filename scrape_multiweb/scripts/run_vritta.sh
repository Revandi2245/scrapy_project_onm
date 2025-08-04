#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=vritta \
  -a path=fixtures/vritta_config.json \
  -o output/vritta.json