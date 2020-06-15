
FROM python:3.7-slim

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["scrapy", "runspider", "caps-holder/capsholder/spiders/CapsHolderScraper.py ", "-a", "config=nypos", "-s", "SQLITE3_DIR=/data"]