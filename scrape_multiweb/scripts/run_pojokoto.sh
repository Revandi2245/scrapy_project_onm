#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=pojokoto \
  -a path=fixtures_olx/pojokoto_config.json \
  -o output/pojokoto.json