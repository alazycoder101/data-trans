FROM ruby:3.1.1-alpine

ARG app=/opt/app

WORKDIR $app

COPY Gemfile ./
RUN gem update bundler
RUN bundle install --jobs 4 --retry 3

COPY . ./

CMD bundle exec bin/json_process
