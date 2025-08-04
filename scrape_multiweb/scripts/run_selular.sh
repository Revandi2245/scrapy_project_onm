#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=selular \
  -a path=fixtures/selular_config.json \
  -o output/selular.json