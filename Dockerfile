FROM python:3.9-slim
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wkhtmltopdf \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY . /app
RUN pip install -r requirements.txt
ENV FLASK_APP=app.py

CMD ["flask", "run", "--host=0.0.0.0"]
