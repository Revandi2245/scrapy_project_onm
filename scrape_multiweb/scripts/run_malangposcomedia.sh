#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=malangposcomedia \
  -a path=fixtures/malangposcomedia_config.json