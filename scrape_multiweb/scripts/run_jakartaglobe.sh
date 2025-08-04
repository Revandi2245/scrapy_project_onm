#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=jakartaglobe \
  -a path=fixtures/jakartaglobe_config.json \
  -o output/jakartaglobe.json