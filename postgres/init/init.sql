-- init.sql
-- Connect to the postgres database to avoid connection issues
\c postgres

-- Create database if it doesn't exist
SELECT 'CREATE DATABASE academia2025_prod'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'academia2025_prod')\gexec

-- Connect to the new database
\c academia2025_prod

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Set database owner to postgres
ALTER DATABASE academia2025_prod OWNER TO postgres;

-- Grant all privileges to postgres user
GRANT ALL PRIVILEGES ON DATABASE academia2025_prod TO postgres;

-- Ensure the postgres user has the correct password
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'postgres') THEN
    EXECUTE format('ALTER USER postgres WITH PASSWORD %L', current_setting('POSTGRES_PASSWORD'));
  END IF;
END
$$;
