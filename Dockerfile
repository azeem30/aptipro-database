FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=Azeem@123
ENV MYSQL_DATABASE=aptipro

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306