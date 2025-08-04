#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=pelitabatak \
  -a path=fixtures/pelitabatak_config.json \
  -o output/pelitabatak.json