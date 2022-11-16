FROM postgres:14.3-bullseye
COPY dbinit/* /docker-entrypoint-initdb.d/
COPY postgres.sh /
#RUN pg_restore -f /docker-entrypoint-initdb.d/ulule -v
# pg_restore --verbose --clean --no-acl --no-owner -U postgres -f /docker-entrypoint-initdb.d/ulule
