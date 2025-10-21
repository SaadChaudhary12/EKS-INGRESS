# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# system deps if needed (e.g., mysql client)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential default-libmysqlclient-dev libssl-dev gcc \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=app.py
ENV FLASK_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["gunicorn", "--bind", "0.0.0.0:3000", "app:app", "--workers", "3", "--threads", "2"]
