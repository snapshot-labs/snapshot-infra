FROM mysql:8.0

COPY ./init-databases.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-databases.sh
