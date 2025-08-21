import scrapy
import json
from datetime import datetime, timezone

class GenericRssContentsSpider(scrapy.Spider):
    name = "generic_rss_spider"

    def __init__(self, spider_name=None, path=None, *args, **kwargs):
        super().__init__(*args, **kwargs)

        if not spider_name or not path:
            raise ValueError("Harus menyertakan spider_name dan path ke config JSON")

        # 1. Load konfigurasi json
        with open(path) as f:
            all_configs = json.load(f)

        # 2. Temukan konfigurasi yang sesuai dengan input spider_name
        self.config = next((c for c in all_configs if c["spider_name"] == spider_name), None)
        if not self.config:
            raise ValueError(f"Config dengan spider_name '{spider_name}' tidak ditemukan.")

        # 3. Set field penting dari config
        self.portal = self.config.get("portal", {})
        self.start_urls = self.portal.get("rss_urls", [])   # khusus RSS
        self.allowed_domains = [self.portal.get("domain")]

        # 4. Custom settings (jika ada)
        self.custom_settings = self.config.get("custom_settings", {})

    def parse(self, response):
        # Loop tiap <item> di RSS
        for item in response.xpath("//item"):
            yield {
                "source_name": self.portal.get("name"),
                "title": item.xpath("title/text()").get(),
                "description": item.xpath("description/text()").get(),
                "pubDate": item.xpath("pubDate/text()").get(),
                
                "metadata": {
                    "created_at": datetime.now(timezone.utc).isoformat()
                }
            }
