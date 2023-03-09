FROM python:3.9-alpine

WORKDIR /app

ADD . /app

RUN pip install -r requirements.txt

ENV DB_HOST = "host ip"
ENV DB_PORT = 3306
ENV DB_USER = "admin"
ENV DB_PASSWORD = "password"
ENV DB_NAME = "db name"

EXPOSE 8080

CMD ["python", "main.py"]
