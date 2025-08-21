# Stage 1: Builder
FROM node:18-alpine AS builder

WORKDIR /usr/src/app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar todas las dependencias (incluyendo devDependencies para la compilación)
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Compilar el código TypeScript a JavaScript
RUN npm run build

# Stage 2: Development
FROM node:18-alpine AS development

WORKDIR /usr/src/app

# Crear un usuario y grupo no-root para la aplicación
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar todas las dependencias (incluyendo dev para desarrollo)
RUN npm install

# Copiar el código fuente
COPY . .

# Asignar la propiedad de los archivos al usuario no-root
RUN chown -R appuser:appgroup /usr/src/app

# Cambiar al usuario no-root
USER appuser

# Exponer el puerto de la aplicación
EXPOSE 3000

# Comando para desarrollo
CMD ["npm", "run", "dev"]

# Stage 3: Production
FROM node:18-alpine AS production

WORKDIR /usr/src/app

# Crear un usuario y grupo no-root para la aplicación
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar solo las dependencias de producción
RUN npm install --omit=dev

# Copiar los artefactos de compilación desde la etapa anterior
COPY --from=builder /usr/src/app/dist ./dist

# Copiar el script de entrypoint
COPY monitoring/scripts/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Instalar postgres-client para el healthcheck
RUN apk add --no-cache postgresql-client

# Asignar la propiedad de los archivos al usuario no-root
RUN chown -R appuser:appgroup /usr/src/app

# Cambiar al usuario no-root
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) }).on('error', () => process.exit(1))"

# Exponer el puerto de la aplicación
EXPOSE 3000

# Usar el entrypoint para la inicialización
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Comando para iniciar la aplicación
CMD ["node", "dist/app.js"]