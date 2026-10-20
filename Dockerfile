# Small official pyton image
FROM python:3.12-slim

# Do not write .pyc files: print logs immediately
ENV PYTHONDONOTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /code

# Copy requirements first so Docker can cache this layer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY app/ ./app/

WORKDIR /code/app

EXPOSE 8080

CMD ["gunicorn", \
     "--bind", "0.0.0.0:8080", \
     "--worker-class", "gthread", \
     "--workers", "2", \
     "--threads", "4", \
     "main:app"]
