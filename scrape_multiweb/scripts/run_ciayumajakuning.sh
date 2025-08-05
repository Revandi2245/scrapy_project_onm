#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=ciayumajakuning \
  -a path=fixtures_olx/ciayumajakuning_config.json \
  -o output/ciayumajakuning.json