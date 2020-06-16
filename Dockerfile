
FROM python:3.7-slim
ENV PYTHONPATH=/app/caps-holder

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["scrapy", "runspider", "caps-holder/capsholder/spiders/CapsHolderScraper.py", "-a", "config=nypost", "-s", "SQLITE3_DIR=/data"]
