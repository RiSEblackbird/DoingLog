FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /DoingLog
ENV APP_ROOT /DoingLog
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler -v 2.0.1
RUN bundle install
ADD . $APP_ROOT

RUN mkdir -p tmp/sockets