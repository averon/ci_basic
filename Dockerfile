FROM ruby
RUN mkdir /urlshortener
WORKDIR /urlshortener
ADD Gemfile /urlshortener/Gemfile
ADD Gemfile.lock /urlshortener/Gemfile.lock
RUN bundle install
ADD . /urlshortener
