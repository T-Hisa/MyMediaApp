FROM ruby:2.7.1
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends yarn
# RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/apt/sources.list.d/yarn.lis && \
    # apt-get install -y yarn
# sudo yum install yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#     echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
#     apt-get install -y yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app


# なんかここのサイトにある通りに実行したらうまくいった？
# https://qiita.com/blindsoup2p1/items/8ed98b5ba15d1d6c6a7c