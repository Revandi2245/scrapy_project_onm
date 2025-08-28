import scrapy
import json


class MsnDetailSpider(scrapy.Spider):
    name = "msn_detail"
    allowed_domains = ["assets.msn.com"]

    def start_requests(self):
        url = "https://assets.msn.com/content/view/v2/Detail/en-my/AA1KQTi7"
        headers = {
            "User-Agent": "Mozilla/5.0",
            "Accept": "application/json"
        }
        yield scrapy.Request(url, headers=headers, callback=self.parse)

    def parse(self, response):
        data = json.loads(response.text)

        yield {
            "id": data.get("id"),
            "title": data.get("title"),
            "authors": data.get("authors"),
            "abstract": data.get("abstract"),
            "source": data.get("sourceHref"),
            "body": data.get("body"),
            "published_at": data.get("publishedDateTime"),
        }
