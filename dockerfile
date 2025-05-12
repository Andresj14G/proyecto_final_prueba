### Dockerfile for Calculadora de Consumo de Combustible

FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends octave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo el contenido de la raíz, incluyendo main.py y la carpeta del proyecto
COPY . .

ENV PORT=8000
EXPOSE $PORT

# Comando corregido: el archivo main.py está en raíz
CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:$PORT"]
