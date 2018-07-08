FROM ruby:2.5.1-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y apt-utils dialog
RUN apt-get install -y build-essential libpq-dev curl supervisor nginx

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install yarn -g

RUN apt-get remove --purge --auto-remove -y curl && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN gem update bundler
