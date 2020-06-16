import scrapy

from capsholder.config.ConfigLoader import ConfigLoader


class CapsHolderScraper(scrapy.Spider):
    name = 'caps-holder-spider'

    def __init__(self, **kwargs):
        super().__init__(None, **kwargs)
        if hasattr(self, 'config'):
            self.config = ConfigLoader.load(self.config)
            self.start_urls = self.config.start_urls
            self.allowed_domains = self.config.allowed_domains

    def parse(self, response):
        page_title = response.xpath(self.config.page_title).extract_first()
        page_desc = response.xpath(self.config.page_desc).extract_first()
        modified_time = response.xpath(self.config.modified_time).extract_first()
        published_time = response.xpath(self.config.published_time).extract_first()

        yield {
            'url': response.url,
            'page_title': page_title,
            'page_desc': page_desc,
            'published_time': published_time,
            'modified_time': modified_time
        }

        if self.config.follow_links:
            link_extractor = self.config.link_extractor
            for node_list_selector in self.config.node_list_selectors:
                for sel in response.css(node_list_selector):
                    next_page = sel.css(link_extractor).extract_first()

                    if next_page:
                        yield scrapy.Request(
                            response.urljoin(next_page),
                            callback=self.parse
                        )
