FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm\
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash

RUN mkdir /blogs

WORKDIR /blogs

COPY Gemfile /blogs/Gemfile
COPY Gemfile.lock /blogs/Gemfile.lock

RUN bundle install
RUN npm install -g yarn
RUN yarn install --check-files

COPY . /blogs
COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
