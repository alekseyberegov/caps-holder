import scrapy

from capsholder.config.ConfigLoader import ConfigLoader


class CapsHolderScraper(scrapy.Spider):
    name = 'capsholder-spider'

    def __init__(self,  **kwargs):
        super().__init__(None, **kwargs)
        if hasattr(self, 'config'):
            self.config = ConfigLoader.load(self.config)
            self.start_urls = self.config.start_urls

    def parse(self, response):
        page_title = response.xpath(self.config.page_title).extract_first()
        page_desc = response.xpath(self.config.page_desc).extract_first()

        yield {
            'url': response.url,
            'page_title': page_title,
            'page_desc': page_desc
        }

        if self.config.follow_links:
            link_extractor = self.config.link_extractor
            for elem_set in response.css(self.config.element_set):
                next_page = elem_set.css(link_extractor).extract_first()

                if next_page:
                    yield scrapy.Request(
                        response.urljoin(next_page),
                        callback=self.parse
                    )


