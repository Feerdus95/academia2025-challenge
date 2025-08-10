-- init.sql
-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS academia2025_prod;

-- Crear usuario si no existe
DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'api_user') THEN
      CREATE ROLE api_user WITH LOGIN PASSWORD 'secure_password_123';
   END IF;
END
$$;

-- Otorgar permisos
GRANT ALL PRIVILEGES ON DATABASE academia2025_prod TO api_user;
