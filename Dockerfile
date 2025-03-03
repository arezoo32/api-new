FROM continuumio/miniconda3

WORKDIR /app

COPY . /app

RUN conda create -n myenv python=3.6.13 && conda clean -afy

RUN echo "conda activate myenv" >> ~/.bashrc
RUN conda activate myenv && conda install -c intel mkl-service && conda clean -afy

RUN conda activate myenv && pip install --upgrade pip setuptools wheel
RUN conda activate myenv && pip install -r requirements.txt


CMD conda activate myenv && gunicorn app:app --bind 0.0.0.0:${PORT:-8000}
