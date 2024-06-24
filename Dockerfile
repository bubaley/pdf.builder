FROM python:3.9.2-alpine3.13

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /code

RUN apk update
RUN apk add wkhtmltopdf libffi-dev xvfb ttf-dejavu fontconfig

RUN ln -s /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
RUN chmod +x /usr/local/bin/wkhtmltopdf

RUN pip install --upgrade pip
RUN pip install -U pip setuptools
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/
