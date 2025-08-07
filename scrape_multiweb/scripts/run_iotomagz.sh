#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=iotomagz \
  -a path=fixtures_olx/iotomagz_config.json \
  -o output/iotomagz.json