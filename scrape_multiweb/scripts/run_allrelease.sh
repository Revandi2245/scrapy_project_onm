#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=allrelease \
  -a path=fixtures/allrelease_config.json \
  -o output/allrelease.json