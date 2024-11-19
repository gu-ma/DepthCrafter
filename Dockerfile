# Base image used as starter
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Install dependencies + tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    python3-pip \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    wget \
    curl \
    iproute2 \
    iputils-ping \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# Update pip
RUN pip install -U --no-cache-dir pip setuptools wheel

# Copy content to image
COPY . /src

# Install requirements
RUN pip install -r /src/requirements.txt

# Symlink python
RUN ln -n /usr/bin/python3 /usr/bin/python