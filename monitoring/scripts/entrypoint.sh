#!/bin/sh
set -e

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
# Read password from file if not set in environment
if [ -z "$POSTGRES_PASSWORD" ] && [ -f "/run/secrets/postgres_password" ]; then
  export POSTGRES_PASSWORD=$(cat /run/secrets/postgres_password)
fi

# Ensure required environment variables are set
export PGPASSWORD=${POSTGRES_PASSWORD}

echo "Connecting to PostgreSQL with user: $DB_USER, host: $DB_HOST, database: $DB_NAME"

until psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

echo "Running database migrations..."
npx prisma migrate deploy

echo "Starting application..."
exec "$@"
