#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=wartapol \
  -a path=fixtures/wartapol_config.json \
  -o output/wartapol.json