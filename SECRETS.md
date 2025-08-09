# 🔒 Gestión de Secretos y Variables de Entorno

Este documento detalla todos los secretos y variables de entorno necesarios para el despliegue y operación de la aplicación, siguiendo los requisitos de `DEPLOYMENT_REQUIREMENTS.md`.

## 📋 Tabla de Contenidos

- [1. Configuración Básica](#1-configuración-básica)
- [2. Docker y Registro](#2-docker-y-registro)
- [3. Base de Datos](#3-base-de-datos)
- [4. Monitoreo](#4-monitoreo)
- [5. Logging](#5-logging)
- [6. Notificaciones](#6-notificaciones)
- [7. Seguridad](#7-seguridad)
- [8. Testing](#8-testing)
- [9. Variables Calculadas](#9-variables-calculadas)
- [10. Configuración por Entorno](#10-configuración-por-entorno)
- [11. Guía de Implementación](#11-guía-de-implementación)

## 1. Configuración Básica

| Variable      | Requerido | Valor por Defecto | Descripción                                                   |
| ------------- | --------- | ----------------- | ------------------------------------------------------------- |
| `NODE_ENV`    | ✅        | `production`      | Entorno de ejecución (`production`, `staging`, `development`) |
| `PORT`        | ✅        | `3000`            | Puerto de la aplicación                                       |
| `API_PREFIX`  | ❌        | `/api`            | Prefijo para las rutas de la API                              |
| `CORS_ORIGIN` | ✅        | `*`               | Orígenes permitidos para CORS                                 |

## 2. Docker y Registro

### 2.1 Docker Hub

| Variable          | Requerido | Descripción                   |
| ----------------- | --------- | ----------------------------- | ---------------------------- |
| `DOCKER_USERNAME` | ✅        | Usuario de Docker Hub         |
| `DOCKER_PASSWORD` | ✅        | Token de acceso de Docker Hub |
| `DOCKER_REGISTRY` | ❌        | `docker.io`                   | URL del registro de imágenes |

### 2.2 Configuración de la VM

| Variable          | Requerido | Valor por Defecto | Descripción                      |
| ----------------- | --------- | ----------------- | -------------------------------- |
| `SSH_PRIVATE_KEY` | ✅        | -                 | Clave SSH privada para la VM     |
| `REMOTE_USER`     | ✅        | -                 | Usuario SSH (ej: ubuntu, deploy) |
| `REMOTE_HOST`     | ✅        | -                 | IP o hostname de la VM           |
| `REMOTE_PORT`     | ❌        | `22`              | Puerto SSH                       |

## 3. Base de Datos

### 3.1 PostgreSQL

| Variable            | Requerido | Valor por Defecto | Descripción                            |
| ------------------- | --------- | ----------------- | -------------------------------------- |
| `POSTGRES_USER`     | ✅        | -                 | Usuario de PostgreSQL                  |
| `POSTGRES_PASSWORD` | ✅        | -                 | Contraseña de PostgreSQL               |
| `POSTGRES_DB`       | ✅        | -                 | Nombre de la base de datos             |
| `POSTGRES_HOST`     | ✅        | `postgres`        | Host de la base de datos               |
| `POSTGRES_PORT`     | ❌        | `5432`            | Puerto de PostgreSQL                   |
| `DATABASE_URL`      | ❌        | -                 | URL completa de conexión (alternativa) |

## 4. Monitoreo

### 4.1 Grafana

| Variable                     | Requerido | Valor por Defecto | Descripción                         |
| ---------------------------- | --------- | ----------------- | ----------------------------------- |
| `GF_SECURITY_ADMIN_USER`     | ✅        | `admin`           | Usuario administrador               |
| `GF_SECURITY_ADMIN_PASSWORD` | ✅        | -                 | Contraseña de administrador         |
| `GF_INSTALL_PLUGINS`         | ❌        | -                 | Plugins adicionales de Grafana      |
| `GRAFANA_API_KEY`            | ✅        | -                 | API key para integraciones externas |

### 4.2 Prometheus

| Variable                     | Requerido | Valor por Defecto | Descripción                    |
| ---------------------------- | --------- | ----------------- | ------------------------------ |
| `PROMETHEUS_RETENTION`       | ❌        | `15d`             | Retención de métricas          |
| `PROMETHEUS_SCRAPE_INTERVAL` | ❌        | `15s`             | Intervalo de scraping          |
| `PROMETHEUS_TOKEN`           | ✅        | -                 | Token para acceso a Prometheus |

### 4.3 cAdvisor

| Variable        | Requerido | Valor por Defecto | Descripción        |
| --------------- | --------- | ----------------- | ------------------ |
| `CADVISOR_PORT` | ❌        | `8080`            | Puerto de cAdvisor |

## 5. Logging

### 5.1 Loki

| Variable                | Requerido | Valor por Defecto  | Descripción                 |
| ----------------------- | --------- | ------------------ | --------------------------- |
| `LOKI_URL`              | ✅        | `http://loki:3100` | URL del servidor Loki       |
| `LOKI_RETENTION_PERIOD` | ❌        | `720h`             | Retención de logs (30 días) |

### 5.2 Promtail

| Variable               | Requerido | Valor por Defecto          | Descripción                      |
| ---------------------- | --------- | -------------------------- | -------------------------------- |
| `PROMTAIL_CONFIG_FILE` | ❌        | `/etc/promtail/config.yml` | Ruta al archivo de configuración |

## 6. Notificaciones

### 6.1 Discord

| Variable              | Requerido | Descripción                               |
| --------------------- | --------- | ----------------------------------------- |
| `DISCORD_WEBHOOK_URL` | ✅        | Webhook para notificaciones de deployment |

### 6.2 Email (SMTP)

| Variable        | Requerido | Descripción               |
| --------------- | --------- | ------------------------- |
| `SMTP_HOST`     | ❌        | Servidor SMTP             |
| `SMTP_PORT`     | ❌        | Puerto SMTP               |
| `SMTP_USER`     | ❌        | Usuario SMTP              |
| `SMTP_PASSWORD` | ❌        | Contraseña SMTP           |
| `ALERT_EMAIL`   | ❌        | Email para notificaciones |

## 7. Seguridad

### 7.1 Autenticación

| Variable               | Requerido | Descripción                    |
| ---------------------- | --------- | ------------------------------ | ------------------------------ |
| `JWT_SECRET`           | ✅        | Secreto para firmar tokens JWT |
| `JWT_EXPIRES_IN`       | ❌        | `24h`                          | Tiempo de expiración del token |
| `PASSWORD_SALT_ROUNDS` | ❌        | `10`                           | Número de rondas de hashing    |

### 7.2 SSL/TLS

| Variable      | Requerido | Descripción                        |
| ------------- | --------- | ---------------------------------- |
| `SSL_EMAIL`   | ❌        | Email para Let's Encrypt           |
| `SSL_DOMAIN`  | ❌        | Dominio para el certificado        |
| `SSL_STAGING` | ❌        | `true` para certificados de prueba |

## 8. Testing

### 8.1 Cobertura y Calidad

| Variable        | Requerido | Descripción                             |
| --------------- | --------- | --------------------------------------- |
| `CODECOV_TOKEN` | ❌        | Token para reportar cobertura de código |

### 8.2 Base de Datos de Test

| Variable            | Requerido | Descripción                     |
| ------------------- | --------- | ------------------------------- |
| `TEST_DATABASE_URL` | ❌        | URL de base de datos para tests |

## 9. Variables Calculadas

Estas variables se construyen automáticamente a partir de otras:

```bash
# URL completa de base de datos
DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}

# URLs de monitoreo
PROMETHEUS_URL=http://prometheus:9090
GRAFANA_URL=http://grafana:3000
LOKI_URL=http://loki:3100

# Configuración de Docker Swarm
SWARM_MANAGER_TOKEN=${SWARM_MANAGER_TOKEN}
SWARM_WORKER_TOKEN=${SWARM_WORKER_TOKEN}
```

## 10. Configuración por Entorno

### 10.1 Producción

```bash
NODE_ENV=production
PORT=3000
CORS_ORIGIN=https://tudominio.com

# Docker
DOCKER_USERNAME=tu_usuario
DOCKER_PASSWORD=tu_token

# VM
REMOTE_USER=ubuntu
REMOTE_HOST=192.168.1.100
REMOTE_PORT=22

# Base de Datos
POSTGRES_USER=prod_user
POSTGRES_PASSWORD=contraseña_fuerte_123!
POSTGRES_DB=academia2025_prod

# Seguridad
JWT_SECRET=tu_secreto_muy_seguro_256_bits

# Monitoreo
GF_SECURITY_ADMIN_PASSWORD=grafana_admin_pass_123!
PROMETHEUS_TOKEN=prometheus_token_seguro
GRAFANA_API_KEY=eyJrIjoiZ3JhZmFuYV9hcGlfa2V5X2V4YW1wbGUi

# Notificaciones
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/123456789/abcdef
```

### 10.2 Staging

```bash
NODE_ENV=staging
PORT=3001
CORS_ORIGIN=https://staging.tudominio.com

# Base de Datos
POSTGRES_USER=staging_user
POSTGRES_PASSWORD=otra_contraseña_fuerte_456!
POSTGRES_DB=academia2025_staging

# SSL
SSL_STAGING=true
SSL_EMAIL=admin@tudominio.com
SSL_DOMAIN=staging.tudominio.com
```

### 10.3 Development

```bash
NODE_ENV=development
PORT=3000
CORS_ORIGIN=http://localhost:3001

# Base de Datos
POSTGRES_USER=dev_user
POSTGRES_PASSWORD=dev_password
POSTGRES_DB=academia2025_dev

# Monitoreo (opcional en desarrollo)
GF_SECURITY_ADMIN_PASSWORD=admin
```

## 11. Guía de Implementación

### 11.1 Configuración en GitHub Secrets

1. Ve a la configuración de tu repositorio en GitHub
2. Navega a "Secrets and variables" > "Actions"
3. Haz clic en "New repository secret"
4. Ingresa el nombre de la variable y su valor
5. Repite para todos los secretos necesarios

#### Secretos requeridos en GitHub:

```bash
# Docker
DOCKER_USERNAME
DOCKER_PASSWORD

# SSH
SSH_PRIVATE_KEY
REMOTE_USER
REMOTE_HOST
REMOTE_PORT

# Base de Datos
DATABASE_URL (o componentes individuales)
DB_USER
DB_PASSWORD

# API
JWT_SECRET

# Monitoreo
GRAFANA_API_KEY
PROMETHEUS_TOKEN

# Notificaciones
DISCORD_WEBHOOK_URL
CODECOV_TOKEN (opcional)
```

### 11.2 Archivos de Secretos para Docker Swarm

Crea los siguientes archivos en el directorio `secrets/`:

```bash
# secrets/db_url.txt
postgres://prod_user:contraseña_fuerte_123!@postgres:5432/academia2025_prod

# secrets/db_user.txt
prod_user

# secrets/db_password.txt
contraseña_fuerte_123!

# secrets/jwt_secret.txt
tu_secreto_muy_seguro_256_bits
```

### 11.3 Variables de Entorno Locales

Crea un archivo `.env` en la raíz del proyecto:

```bash
# Copia el archivo de ejemplo
cp .env.example .env

# Edita el archivo con tus valores
nano .env
```

### 11.4 Prueba de Variables

```bash
# Verifica que las variables estén configuradas
npm run env:check

# Lista todas las variables de entorno
printenv | grep -E "NODE_ENV|PORT|DATABASE_URL"
```

### 11.5 Rotación de Secretos

1. Genera nuevos valores para los secretos
2. Actualiza los secretos en GitHub y en los entornos de despliegue
3. Actualiza los archivos en `secrets/`
4. Reinicia los servicios afectados:
   ```bash
   docker service update --secret-rm old_secret --secret-add new_secret academia2025_api
   ```

### 11.6 Seguridad Adicional

- ✅ Nunca guardes archivos `.env` en el repositorio
- ✅ Usa un gestor de secretos para producción
- ✅ Revisa los permisos de los archivos de configuración (`chmod 600`)
- ✅ Rota los secretos regularmente (cada 90 días)
- ✅ Usa secretos diferentes para cada entorno
- ✅ Monitorea el acceso a los secretos

---

📌 **Nota**: Este archivo debe mantenerse actualizado con cualquier cambio en la configuración de la aplicación.
