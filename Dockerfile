
FROM python:3.7-slim

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["python", "-m", "caps-holder", "run"]