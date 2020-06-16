import json
import sqlite3
from datetime import datetime
from json import JSONDecodeError
from pathlib import Path

from capsholder.stubs.cats.Stub import Stub


class SQLitePipeline:
    create_table_sql = """
        create table caps_holder(
                ts          timestamp
            ,   published   text
            ,   modified    text
            ,   url         text
            ,   title       text
            ,   desc        text
            ,   search      text
            ,   cats        text)
    """

    insert_row_sql = """
        insert into caps_holder(ts, published, modified, url, title, desc, search, cats) 
        values (?, ?, ?, ?, ?, ?, ?, ?)
    """

    def __init__(self, sqlite3_db_dir, cats_endpoint, cats_debug):
        self.sqlite3_db_dir = sqlite3_db_dir
        self.cats = Stub(cats_endpoint, cats_debug)
        self.con = None
        self.stmt = None

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            sqlite3_db_dir=crawler.settings.get('SQLITE3_DIR'),
            cats_endpoint=crawler.settings.get("CATS_ENDPOINT"),
            cats_debug=crawler.settings.get("CATS_DEBUG")
        )

    def open_spider(self, spider):
        db_file = '_'.join(['caps_holder', datetime.now().strftime("%m_%d_%Y-%H_%M_%S"), '.db'])
        self.con = sqlite3.connect(Path(self.sqlite3_db_dir) / db_file)
        self.stmt = self.con.cursor()
        self.stmt.execute(self.create_table_sql)

    def close_spider(self, spider):
        self.stmt.close()
        self.con.close()

    def process_item(self, item, spider):
        url = item['url']
        page_title = item['page_title']
        page_desc = item['page_desc']
        published_time = item['published_time']
        modified_time = item['modified_time']

        cats_resp = self.cats.send(url)
        search = self.extract_search(cats_resp)

        self.stmt.execute(self.insert_row_sql,
                          (datetime.now(), published_time, modified_time, url, page_title, page_desc, search, cats_resp))
        self.con.commit()
        return item

    @staticmethod
    def extract_search(payload):
        try:
            data = json.loads(payload)
            return data['search']['query']
        except JSONDecodeError:
            return None
