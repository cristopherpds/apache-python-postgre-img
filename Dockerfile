# Usamos Ubuntu como base
FROM ubuntu:latest

# Evitar prompts interactivos
#ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos paquetes y add dependencias
RUN apt-get update && apt-get install -y \
    apache2 \
    python3 \
    python3-pip \
    postgresql \
    postgresql-contrib \
    libapache2-mod-wsgi-py3 \
    && apt-get clean

# Exponemos los puertos (80 para Apache, 5432 para PostgreSQL)

# Configuracion PostgreSQL port
RUN sed -i 's/#port = 5432/port = 5435/' /etc/postgresql/14/main/postgresql.conf

# Configuracion PostgreSQL authentication y port
RUN service postgresql start && \
    pg_version=$(ls /etc/postgresql/) && \
    su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'password';\"" && \
    echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/$pg_versionmain/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/$pg_version/main/postgresql.conf && \
    service postgresql stop

# Configure Apache WSGI
RUN a2enmod wsgi && \
    echo "WSGIPythonPath /var/www/html/" > /etc/apache2/conf-available/wsgi.conf && \
    a2enconf wsgi

EXPOSE 80 5435
# Definir volumen para persistencia de PostgreSQL
VOLUME ["/var/lib/postgresql/data"]

# Comando para ejecutar Apache y PostgreSQL al iniciar el contenedor
CMD ["sh", "-c", "service postgresql start && apachectl -D FOREGROUND"]

