#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=autoindo \
  -a path=fixtures_olx/autoindo_config.json \
  -o output/autoindo.json