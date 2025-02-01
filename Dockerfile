# Usamos Ubuntu como base
FROM ubuntu:latest

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos paquetes y add dependencias
RUN apt-get update && apt-get install -y \
    apache2 \
    python3 \
    python3-pip \
    libapache2-mod-wsgi-py3 \
    postgresql \
    postgresql-contrib \
    && apt-get clean

# Configuración de PostgreSQL para usar el puerto 5432
RUN PG_CONF_DIR=$(find /etc/postgresql/ -name postgresql.conf | head -n 1 | xargs dirname) && \
    sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF_DIR/postgresql.conf && \
    echo "host all all 0.0.0.0/0 md5" >> $PG_CONF_DIR/pg_hba.conf
    
EXPOSE 80 5432

# Configuración de PostgreSQL
RUN service postgresql start && \
    su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'password';\"" && \
    service postgresql stop
    
# Definir volumen para persistencia de PostgreSQL
VOLUME ["/var/lib/postgresql/data"]

# Habilitar mod_wsgi para Apache
RUN a2enmod wsgi

# Comando para ejecutar Apache y PostgreSQL al iniciar el contenedor
CMD ["sh", "-c", "service postgresql start && apachectl -D FOREGROUND"]

