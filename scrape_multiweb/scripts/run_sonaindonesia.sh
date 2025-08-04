#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=sonaindonesia \
  -a path=fixtures/sonaindonesia_config.json \
  -o output/sonaindonesia.json