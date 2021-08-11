# Find available versions at https://hub.docker.com/_/ruby
FROM ruby:3.0.2-alpine3.14

WORKDIR /app

COPY Gemfile* ./

# Use mirror for apk package
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  # For build essentials, e.g. gcc.
  && apk add --no-cache --virtual .build-deps build-base \
  # For postgresql and timezone.
  && apk add --no-cache postgresql-dev tzdata \
  && bundle config mirror.https://rubygems.org https://gems.ruby-china.com \
  && bundle install --without development test \
  && apk del .build-deps

ARG RAILS_ENV=production

ENV RAILS_ENV="$RAILS_ENV" \
  LANG="en_US.UTF-8" \
  LANGUAGE="en_US.UTF-8" \
  LC_ALL="en_US.UTF-8" \
  TZ="Asia/Shanghai"

# `APP_ENABLE_UNIQUE_LOG_DIR` is useful if the mount volume of the log is shared by
# more than one container. In the volume, each container will have a unique log
# directory.
#
# NOTE: If the container is running in a Kubernetes cluster whose version
# is greater than or equal to 1.17, then you can use
# `VolumeSubpathEnvExpansion` to make each container have a different log
# directory.
ENV APP_ENABLE_UNIQUE_LOG_DIR="0"

# By default we let the container run migrations. You should be careful not to
# run migrations concurrently when you have multiple replicas. You can avoid
# the concurrency problem by controlling only starting one container one time
# or use Kubernetes job to do migrations.
ENV APP_RUN_MIGRATIONS="1"
ENV APP_CHECK_MIGRATIONS="0"

# If the container is for `sidekiq`, then you can set `APP_ROLE` to `sidekiq`.
ENV APP_ROLE=""

COPY app app
COPY bin bin
COPY config config
COPY db/migrate db/migrate
COPY lib lib
COPY public public
COPY vendor vendor
COPY config.ru Rakefile ./

RUN mkdir -p tmp log

COPY docker/docker-entrypoint.sh /

expose 3000

CMD ["/docker-entrypoint.sh"]
