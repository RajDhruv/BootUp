#! /bin/sh

# Wait for MySQL
until nc -z -v -w30 $DB_HOST $DB_PORT; do
 echo 'Waiting for MySQL...'
 sleep 1
done
echo "MySQL is up and running!"


# If the database exists, migrate. Otherwise setup (create and migrate)

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate db:seed
echo "Done!"

# Precompile assets for production
bundle exec rake assets:precompile

echo "Assets Pre-compiled!"

rails s -e production -b 0.0.0.0