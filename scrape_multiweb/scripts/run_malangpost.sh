#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=malang-post \
  -a path=fixtures/malangpost_config.json \
  -o output/malangpost.json