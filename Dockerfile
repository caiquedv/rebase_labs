FROM ruby

WORKDIR /app

RUN apt-get update -y && apt-get install -y chromium-driver