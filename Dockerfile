FROM ruby:2.5.1-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y apt-utils dialog
RUN apt-get install -y build-essential libpq-dev libcurl3 curl supervisor nginx wget

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn

RUN apt-get remove --purge --auto-remove -y curl && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# Install redis.
RUN wget http://download.redis.io/redis-stable.tar.gz \
    && tar xvzf redis-stable.tar.gz \
    && cd redis-stable \
    && make \
    && make install

RUN gem update bundler
