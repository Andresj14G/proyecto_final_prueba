### Dockerfile for Calculadora de Consumo de Combustible
# Use a lightweight Python base image
FROM python:3.11-slim

# Install system dependencies and Octave
RUN apt-get update \
    && apt-get install -y --no-install-recommends octave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /app

# Create and activate a virtual environment to avoid running pip as root
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy and install Python dependencies inside the venv
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code (excluding requirements.txt)
COPY "calculadora consumo combustible/" ./calculadora-consumo-combustible/
COPY backend/ ./backend/

# Expose port (Render will use the PORT env var)
ENV PORT=8000
EXPOSE $PORT

# Start the app with Gunicorn
CMD ["gunicorn", "backend.main:app", "--bind", "0.0.0.0:$PORT"]