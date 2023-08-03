#!/bin/bash

for directory in /schemas/*; do
    if [ -d "$directory" ]; then
        database_name=$(basename -- "$directory")
        
        echo "CREATE DATABASE IF NOT EXISTS \`$database_name\`;" | mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h localhost
        for filename in $directory/*.sql; do
            mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h localhost $database_name < $filename
        done
    fi
done

for directory in /fixtures/*; do
    if [ -d "$directory" ]; then
        database_name=$(basename -- "$directory")
        
        for filename in $directory/*.sql; do
            mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h localhost $database_name < $filename
        done
    fi
done

