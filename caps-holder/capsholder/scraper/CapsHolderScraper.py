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
        link_extractor = self.config.link_extractor
        for elem_set in response.css(self.config.element_set):
            next_page = elem_set.css(link_extractor).extract_first()
            yield {
                'name': next_page,
            }

            if self.config.follow_links and next_page:
                yield scrapy.Request(
                    response.urljoin(next_page),
                    callback=self.parse
                )


