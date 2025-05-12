### Dockerfile for Calculadora de Consumo de Combustible
# NOTE: Ensure your project folder is named without spaces, e.g., `calculadora-consumo-combustible`.
# Place this Dockerfile at the root of your repository, next to requirements.txt and the project folder.

# Use a lightweight Python base image
FROM python:3.11-slim

# Install system dependencies and Octave
RUN apt-get update \
    && apt-get install -y --no-install-recommends octave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Create and activate a virtual environment to avoid running pip as root
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Expose port (Render will inject PORT as an environment variable)
EXPOSE 8000

# Start the app with Gunicorn using shell form so $PORT is evaluated
CMD gunicorn main:app --bind 0.0.0.0:$PORT