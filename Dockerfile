FROM ruby:2.4.1

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y software-properties-common

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install -y nodejs git netcat

RUN mkdir /app

WORKDIR /app

RUN gem install bundler

COPY Gemfile Gemfile.lock ./

RUN gem install ovirt-engine-sdk -v '4.3.0' --source 'https://rubygems.org/'

RUN bundle install --binstubs

COPY . .

EXPOSE 3000

ENTRYPOINT ["sh", "./config/docker/startup.sh"]