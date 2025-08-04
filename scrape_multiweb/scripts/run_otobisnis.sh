#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=otobisnis \
  -a path=fixtures/otobisnis_config.json \
  -o output/otobisnis.json