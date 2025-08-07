#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=spiritnesia \
  -a path=fixtures_olx/spiritnesia_config.json \
  -o output/spiritnesia.json