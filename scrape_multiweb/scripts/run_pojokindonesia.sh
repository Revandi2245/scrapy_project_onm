#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=pojokindonesia \
  -a path=fixtures/pojokindonesia_config.json \
  -o output/pojokindonesia.json