FROM python:3.11-slim

# minimal system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    build-essential \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy only what we need first (for layer caching)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# copy application
COPY . .

# ensure we run the correct Flask file (you use app_lt.py)
ENV FLASK_APP=app_lt.py
ENV FLASK_ENV=production
ENV PORT=3000

EXPOSE 3000

# run gunicorn binding to the expected module: app_lt:app
CMD ["gunicorn", "--bind", "0.0.0.0:3000", "app_lt:app", "--workers", "3", "--threads", "2"]
