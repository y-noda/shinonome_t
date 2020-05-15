FROM ruby:2.3.1

RUN apt-get update && apt-get install -y libqt4-dev libqtwebkit-dev

ENV APP_ROOT /app/
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

ADD Gemfile $APP_ROOT
ADD Gemfile.lock $APP_ROOT

ENV RAILS_ENV test
RUN echo 'gem: --no-document' >> ~/.gemrc
RUN bundle install -j8

ADD . $APP_ROOT

ENV POSTGRESQL_URL 'postgres'

CMD ["./init-docker-app.sh"]
