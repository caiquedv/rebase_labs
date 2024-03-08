FROM ruby:latest

WORKDIR /app

COPY . ./

RUN gem install bundler && bundle install

CMD ["ruby", "server.rb"]
