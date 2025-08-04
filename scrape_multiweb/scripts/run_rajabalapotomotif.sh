#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=rajabalapotomotif \
  -a path=fixtures/rajabalapotomotif_config.json \
  -o output/rajabalapotomotif.json