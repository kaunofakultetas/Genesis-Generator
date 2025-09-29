# Use Ubuntu 18.04 which still has Python 2.7 support
FROM ubuntu:18.04

# Set working directory
WORKDIR /app

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies including Python 2.7
RUN apt-get update && apt-get install -y \
    python2.7 \
    python-pip \
    python-dev \
    gcc \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Ensure python command points to python2.7 (remove existing symlink if present)
RUN rm -f /usr/bin/python && ln -s /usr/bin/python2.7 /usr/bin/python

# Upgrade pip to a version that still supports Python 2.7
RUN python -m pip install --upgrade "pip<21.0"

# Install Python dependencies with specific versions compatible with Python 2.7
RUN python -m pip install scrypt==0.8.20 construct==2.5.2

# Copy the genesis script
COPY genesis.py .

# Create output directory for any generated files
RUN mkdir -p /output

# Set default command to show help
CMD ["python", "genesis.py", "-h"]
