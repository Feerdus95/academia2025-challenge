-- init.sql
-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS academia2025_prod;

-- Cambiar el propietario de la base de datos a postgres
ALTER DATABASE academia2025_prod OWNER TO postgres;

-- Otorgar todos los privilegios al usuario postgres
GRANT ALL PRIVILEGES ON DATABASE academia2025_prod TO postgres;
