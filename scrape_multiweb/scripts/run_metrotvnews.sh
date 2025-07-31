#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=metrotvnews \
  -a path=fixtures/spider_config.json