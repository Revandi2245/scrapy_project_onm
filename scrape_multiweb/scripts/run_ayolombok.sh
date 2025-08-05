#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=ayolombok \
  -a path=fixtures_olx/ayolombok_config.json \
  -o output/ayolombok.json