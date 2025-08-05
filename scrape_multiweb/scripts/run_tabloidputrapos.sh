#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=tabloidputrapos \
  -a path=fixtures/tabloidputrapos_config.json \
  -o output/tabloidputrapos.json