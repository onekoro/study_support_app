FROM ruby:2.6.3
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_USER=postgres
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /study_support_app
WORKDIR /study_support_app
COPY Gemfile /study_support_app/Gemfile
COPY Gemfile.lock /study_support_app/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /study_support_app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
