import scrapy
import json
from scrape_multiweb.items import ScrapeMultiwebItem


class GenericSpiderContents(scrapy.Spider):
    name = "generic_spider_contents"

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
        self.selectors = self.config.get("selectors", {})
        self.start_urls = self.portal.get("seed_urls", [])
        self.allowed_domains = [self.portal.get("domain")]

        # 4. Terapkan custom settings (jika ada)
        self.custom_settings = self.config.get("custom_settings", {})

    def parse(self, response):
        article_list_selector = self.selectors.get("article_url_list", {})
        method = article_list_selector.get("method", "css")
        query = article_list_selector.get("query")

        if method == "css":
            links = response.css(query).getall()
        elif method == "xpath":
            links = response.xpath(query).getall()
        else:
            self.logger.error("Unsupported selector method for article_url_list.")
            return

        for link in links:
            yield response.follow(link, callback=self.parse_article)

    def parse_article(self, response):
        item = {}
        for key, sel in self.selectors.items():
            if key == "article_url_list":
                continue  # Skip list selector

            method = sel.get("method", "css")
            query = sel.get("query")

            if method == "css":
                item[key] = response.css(query).get()
            elif method == "xpath":
                item[key] = response.xpath(query).get()
            else:
                self.logger.warning(f"Unknown method '{method}' for selector '{key}'")
                item[key] = None

        yield {
            "title": item.get("title"),
            "description": item.get("description"),
            "body": item.get("body"),
            "author_list": item.get("author"),
            "image": item.get("image"),
            "date_published": item.get("published_date"),
            "link": item.get("url"),
            "source_name": self.portal.get("source_name"),
            "language": item.get("language"),
            "metadata": {
                "created_at": item.get("created_at")
            }
        }