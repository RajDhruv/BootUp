#! /bin/sh

# Wait for MySQL
until nc -z -v -w30 $DB_HOST $DB_PORT; do
 echo 'Waiting for MySQL...'
 sleep 1
done
echo "MySQL is up and running!"

bundle exec sidekiq -q urgent