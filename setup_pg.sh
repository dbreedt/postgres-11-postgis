# /bin/bash
set -e

/usr/bin/psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  create extension IF NOT EXISTS fuzzystrmatch;
  create extension IF NOT EXISTS pg_trgm;
  create extension IF NOT EXISTS postgis;
  create extension IF NOT EXISTS postgis_topology;
EOSQL

# values from pgtune 5GB RAM + SDD + WebApplication
echo <<-EOF
fsync=off
synchronous_commit=off
full_page_writes=off
wal_level=minimal 
max_worker_processes=2
max_parallel_workers_per_gather=1
max_parallel_workers=2
work_mem=60MB
max_connections=100
shared_buffers=1280MB
effective_cache_size=3840MB
max_wal_senders=0
archive_mode=off
maintenance_work_mem=100MB
checkpoint_completion_target=0.7
wal_buffers=16MB
random_page_cost=1.1
effective_io_concurrency=200
min_wal_size=1GB
max_wal_size=2GB
EOF >> /var/lib/postgresql/data/postgresql.conf
