FROM python:3.11.1-slim

## ENVS variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

## System dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential
RUN rm -rf /var/lib/apt/lists/*

## Project dependencies
COPY ./Envs/Local/requirements.txt /tmp/Requirements/requirements.txt
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r /tmp/Requirements/requirements.txt
RUN rm -r -f /tmp/Requirements

## Project files
RUN mkdir -p /App/
COPY ./main.py /App/main.py
WORKDIR /App
