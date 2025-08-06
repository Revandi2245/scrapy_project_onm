#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=sinarharapan \
  -a path=fixtures/sinarharapan_config.json \
  -o output/sinarharapan.json