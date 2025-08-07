#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=mounture \
  -a path=fixtures/mounture_config.json \
  -o output/mounture.json