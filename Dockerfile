# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (optional basics)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose app port
EXPOSE 8000

# Run the app
CMD ["python", "app.py"]