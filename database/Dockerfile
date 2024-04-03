FROM mysql:8.1.0

COPY ./setup.sql /docker-entrypoint-initdb.d/setup.sql

ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

ENV MYSQL_DATABASE=miu

ENV LANG=C.UTF-8
ENV MYSQL_CHARSET=utf8mb4
ENV MYSQL_COLLATION=utf8mb4_general_ci

EXPOSE 3306