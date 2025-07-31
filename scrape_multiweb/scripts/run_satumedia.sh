#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=satumedia \
  -a path=fixtures/spider_config.json