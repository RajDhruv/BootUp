FROM ruby:2.4.1-alpine

RUN apk add  --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1

RUN apk update && apk upgrade && apk add ruby ruby-json ruby-io-console ruby-bundler ruby-irb ruby-bigdecimal tzdata postgresql-dev && apk add curl-dev ruby-dev build-base libffi-dev && apk add build-base libxslt-dev libxml2-dev ruby-rdoc mysql-dev sqlite-dev

RUN mkdir /app

WORKDIR /app

RUN gem install bundler

COPY Gemfile ./

RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["sh", "./config/docker/startup.sh"]