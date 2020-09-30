FROM postgis/postgis:11-2.5-alpine
COPY setup_pg.sh /docker-entrypoint-initdb.d
