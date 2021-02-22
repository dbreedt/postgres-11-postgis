#! /bin/bash
set -e

/usr/local/bin/psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  create extension IF NOT EXISTS fuzzystrmatch;
  create extension IF NOT EXISTS pg_trgm;
  create extension IF NOT EXISTS postgis;
  create extension IF NOT EXISTS postgis_topology;
EOSQL

# values from pgtune 1GB RAM + 2CPU + 20connections + SDD + WebApplication

echo fsync=off >> /var/lib/postgresql/data/postgresql.conf
echo synchronous_commit=off >> /var/lib/postgresql/data/postgresql.conf
echo full_page_writes=off >> /var/lib/postgresql/data/postgresql.conf
echo work_mem=20MB >> /var/lib/postgresql/data/postgresql.conf
echo max_connections=20 >> /var/lib/postgresql/data/postgresql.conf
echo shared_buffers=256MB >> /var/lib/postgresql/data/postgresql.conf
echo effective_cache_size=768MB >> /var/lib/postgresql/data/postgresql.conf
echo archive_mode=off >> /var/lib/postgresql/data/postgresql.conf
echo maintenance_work_mem=128MB >> /var/lib/postgresql/data/postgresql.conf
echo checkpoint_completion_target=0.7 >> /var/lib/postgresql/data/postgresql.conf
echo random_page_cost=1.1 >> /var/lib/postgresql/data/postgresql.conf
echo effective_io_concurrency=200 >> /var/lib/postgresql/data/postgresql.conf
echo max_wal_senders=0 >> /var/lib/postgresql/data/postgresql.conf
echo wal_level=minimal >> /var/lib/postgresql/data/postgresql.conf
echo wal_buffers=16MB >> /var/lib/postgresql/data/postgresql.conf
echo min_wal_size=1GB >> /var/lib/postgresql/data/postgresql.conf
echo max_wal_size=4GB >> /var/lib/postgresql/data/postgresql.conf
