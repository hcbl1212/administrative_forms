FROM ruby:2.5.0

RUN apt-get update && apt-get -y install build-essential

# System prerequisites
RUN apt-get update && apt-get -y install libpq-dev

# If you require additional OS dependencies, install them here:
# RUN apt-get update && apt-get -y install imagemagick nodejs
RUN apt-get update && apt-get -y install nodejs
RUN apt-get update && apt-get -y install libqtwebkit-dev libqtwebkit4

ENV INSTALL_PATH /administrative_forms
RUN mkdir $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH
# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
COPY . $INSTALL_PATH

RUN cp ./config/database.postgres.docker.yml config/database.yml
