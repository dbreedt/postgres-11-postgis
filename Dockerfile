FROM postgres:11
RUN apt update && \
  apt install -y --no-install-recommends wget ca-certificates && \
  update-ca-certificates && \
  cd /tmp && \
  wget https://launchpad.net/~ubuntugis/+archive/ubuntu/ubuntugis-experimental/+build/15675841/+files/libgeos-c1v5_3.7.0-1~bionic0_amd64.deb && \
  wget https://launchpad.net/~ubuntugis/+archive/ubuntu/ubuntugis-experimental/+build/15675841/+files/libgeos-3.7.0_3.7.0-1~bionic0_amd64.deb && \
  find /tmp -name 'lib*.deb' -exec dpkg -i {} + && \
  apt install -y --no-install-recommends postgresql-11-postgis-2.5 postgresql-11-postgis-2.5-scripts && \
  rm -rf /var/lib/apt/lists/*
COPY setup_pg.sh /docker-entrypoint-initdb.d
