import sqlite3
from datetime import datetime
from pathlib import Path


class SQLitePipeline:
    def __init__(self, sqlite3_db_dir):
        self.sqlite3_db_dir = sqlite3_db_dir
        self.con = None
        self.stmt = None

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            sqlite3_db_dir=crawler.settings.get('SQLITE3_DIR')
        )

    def open_spider(self, spider):
        db_file = '_'.join(['caps_holder', datetime.now().strftime("%m_%d_%Y-%H_%M_%S"), '.db'])
        self.con = sqlite3.connect(Path(self.sqlite3_db_dir) / db_file)
        self.stmt = self.con.cursor()
        self.stmt.execute("""
            create table caps_holder(ts timestamp, url text)
            """)

    def close_spider(self, spider):
        self.stmt.close()
        self.con.close()

    def process_item(self, item, spider):
        self.stmt.execute("insert into caps_holder(ts, url) values (?, ?)"
                          , (datetime.now(), item['url']))
        self.con.commit()
        return item
