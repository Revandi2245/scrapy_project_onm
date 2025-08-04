#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=hargo \
  -a path=fixtures/hargo_config.json \
  -o output/hargo.json