#!/bin/sh

sed -i "s|DB_CONNECTION=sqlite|DB_CONNECTION=mysql|" .env
sed -i "s|# DB_HOST=127.0.0.1|DB_HOST=db|" .env
sed -i "s|# DB_PORT=3306|DB_PORT=3306|" .env
sed -i "s|# DB_DATABASE=laravel|DB_DATABASE=tp_conteneurisation|" .env
sed -i "s|# DB_USERNAME=root|DB_USERNAME=root|" .env
sed -i "s|# DB_PASSWORD=|DB_PASSWORD=root|" .env

php artisan key:generate --no-ansi
php artisan migrate --force

exec "$@"
