#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=pomodo \
  -a path=fixtures/spider_config.json