## Build
FROM node:latest as builder
WORKDIR /app
COPY atlas/static/package.json ./
RUN npm install


FROM python:3.9.7-bullseye

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y locales postgresql-client gcc libgeos-dev git libpq-dev python-dev build-essential libgdal-dev && \
    locale-gen fr_FR.UTF-8

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -md /atlas -s /bin/bash atlas

USER atlas

ENV PATH "${PATH}:~/.local/bin"

WORKDIR /atlas/app

COPY requirements.txt /atlas/app

RUN python3 -m pip install --upgrade pip --no-cache-dir \
    && pip install -r requirements.txt  --no-cache-dir 

COPY --chown=atlas . /atlas/app

RUN cd /atlas/app && pip install -e .

COPY --from=builder /app/node_modules /atlas/app/atlas/static/node_modules/

EXPOSE 8080

# ENTRYPOINT [ "/atlas/app/docker-entrypoint.sh" ]
ENTRYPOINT [ "bash" ]
