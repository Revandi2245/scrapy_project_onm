#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=apinusantara \
  -a path=fixtures_olx/apinusantara_config.json \
  -o output/apinusantara.json