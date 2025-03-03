# استفاده از ایمیج Miniconda برای نصب Conda و محیط‌های Python
FROM continuumio/miniconda3

# تعیین دایرکتوری کاری
WORKDIR /app

# کپی فایل‌های پروژه به کانتینر
COPY . /app

# ایجاد محیط conda با پایتون 3.6.13
RUN conda create -n myenv python=3.6.13 && conda clean -afy

# فعال‌سازی محیط و نصب وابستگی‌ها
RUN echo "conda activate myenv" >> ~/.bashrc

RUN conda install -c conda-forge mkl-service && conda clean -afy
RUN conda install -c conda-forge persistent && conda clean -afy



# نصب وابستگی‌ها با pip
# RUN bash -c "source ~/.bashrc && conda activate myenv && pip install --upgrade pip setuptools wheel"
RUN bash -c "source ~/.bashrc && conda activate myenv && pip install -r requirements.txt"

# اجرای API با Gunicorn
CMD ["bash", "-c", "source ~/.bashrc && conda activate myenv && gunicorn app:app --bind 0.0.0.0:${PORT:-8000}"]
