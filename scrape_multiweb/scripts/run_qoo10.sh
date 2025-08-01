#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=qoo10 \
  -a path=fixtures/qoo10_config.json \
  -o output/qoo10.json