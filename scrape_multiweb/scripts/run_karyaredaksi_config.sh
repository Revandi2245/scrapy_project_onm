#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=karyaredaksi \
  -a path=fixtures/karyaredaksi_config.json \
  -o output/karyaredaksi.json