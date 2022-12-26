FROM ruby:3.0.4-alpine

ARG app=/opt/app

WORKDIR $app

COPY Gemfile ./
RUN gem update bundler
RUN bundle install --jobs 4 --retry 3

COPY . ./

CMD bundle exec bin/strip
