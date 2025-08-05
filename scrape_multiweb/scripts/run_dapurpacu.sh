#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=dapurpacu \
  -a path=fixtures_olx/dapurpacu_config.json \
  -o output/dapurpacu.json