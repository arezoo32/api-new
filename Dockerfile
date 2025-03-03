FROM python:3.6.13

WORKDIR /app

COPY . /app
RUN conda install -c intel mkl-service && conda clean -afy

RUN pip install -r requirements.txt


CMD gunicorn app:app --bind 0.0.0.0:${PORT:-8000}
