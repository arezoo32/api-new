FROM python:3.6.13

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

CMD gunicorn app:app --bind 0.0.0.0:${PORT:-8000}
