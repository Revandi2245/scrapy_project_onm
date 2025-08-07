#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=lomboksultan \
  -a path=fixtures_olx/lomboksultan_config.json \
  -o output/lomboksultan.json