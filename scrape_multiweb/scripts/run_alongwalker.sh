#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=alongwalker \
  -a path=fixtures_olx/alongwalker_config.json \
  -o output/alongwalker.json