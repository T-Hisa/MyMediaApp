FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs 
RUN apt-get install -y yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle update && bundle install
COPY . /app