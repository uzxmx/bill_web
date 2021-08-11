#!/bin/sh

set -e

if [ "$APP_ENABLE_UNIQUE_LOG_DIR" = "1" ]; then
  SHARED_LOG_PATH="${SHARED_LOG_PATH:-/var/shared_log}"
  if [ -n "$POD_NAME" ]; then
    log_path="$SHARED_LOG_PATH/$POD_NAME"
  else
    log_path="$SHARED_LOG_PATH/$HOSTNAME"
  fi
  mkdir -p "$log_path"

  # Remove the log directory if it exists before we make a link.
  [ -d log ] && rm -rf log
  ln -s "$log_path" log
fi

mkdir -p tmp/pids

if [ "$APP_RUN_MIGRATIONS" = "1" ]; then
  bundle exec rake db:migrate
elif [ "$APP_CHECK_MIGRATIONS" = "1" ]; then
  bundle exec rake db:abort_if_pending_migrations
fi

if [ "$APP_ROLE" = "sidekiq" ]; then
  bundle exec sidekiq -C config/sidekiq.yml
else
  bundle exec puma -C config/puma.rb
fi
