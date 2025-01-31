# Usamos Ubuntu como base
FROM ubuntu:latest

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos paquetes y add dependencias
RUN apt-get update && apt-get install -y \
    apache2 \
    python3 \
    python3-pip \
    postgresql \
    postgresql-contrib \
    && apt-get clean

# Exponemos los puertos (80 para Apache, 5432 para PostgreSQL)
EXPOSE 80 5432

# Configuración de PostgreSQL
RUN service postgresql start && \
    su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'password';\"" && \
    service postgresql stop
    
# Definir volumen para persistencia de PostgreSQL
VOLUME ["/var/lib/postgresql/data"]

# Comando para ejecutar Apache y PostgreSQL al iniciar el contenedor
CMD ["sh", "-c", "service postgresql start && apachectl -D FOREGROUND"]

