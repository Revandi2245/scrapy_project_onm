#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=hotnews \
  -a path=fixtures/hotnews_config.json \
  -o output/hotnews.json