#!/bin/bash

for directory in /schemas/*; do
    if [ -d "$directory" ]; then
        database_name=$(basename -- "$directory")
        
        echo "CREATE DATABASE IF NOT EXISTS \`$database_name\`;" | mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h localhost
        for filename in $directory/*.sql; do
            mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h localhost $database_name < $filename
        done

        # Apply fixtures
        if [ -d "$directory/fixtures" ]; then
            for filename in $directory/fixtures/*.sql; do
                mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h localhost $database_name < $filename
            done
        fi
    fi
done

