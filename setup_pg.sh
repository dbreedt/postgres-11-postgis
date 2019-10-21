# /bin/bash
set -e

/usr/bin/psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  create extension IF NOT EXISTS fuzzystrmatch;
  create extension IF NOT EXISTS pg_trgm;
  create extension IF NOT EXISTS postgis;
  create extension IF NOT EXISTS postgis_topology;
EOSQL

echo <<-EOF
fsync=off
synchronous_commit=off
full_page_writes=off
wal_level=minimal 
max_worker_processes=2
max_parallel_workers_per_gather=1
max_parallel_workers=2
work_mem=90MB
shared_buffers=2GB
effective_cache_size=5GB
max_wal_senders=0
archive_mode=off
maintenance_work_mem=500MB
checkpoint_completion_target=0.7
wal_buffers=16MB
random_page_cost=1.1
effective_io_concurrency=300
min_wal_size=1GB
max_wal_size=2GB
EOF >> /var/lib/postgresql/data/postgresql.conf
