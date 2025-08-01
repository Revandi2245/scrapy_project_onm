#!/bin/bash
cd "$(dirname "$0")/.."
scrapy crawl generic_spider \
  -a spider_name=ekonosia \
  -a path=fixtures/ekonosia_config.json