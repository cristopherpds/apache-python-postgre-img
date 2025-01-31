# Project Docker Environment

Este README proporciona instrucciones sobre cómo descargar la imagen de Docker y usar el entorno para nuestro proyecto.

## Prerrequisitos

- Docker instalado en tu máquina.

## Descargar la Imagen de Docker

Para descargar la imagen de Docker, usa el siguiente comando:

```sh
docker pull ghcr.io/cristopherpds/apache-python-postgre-img:latest
```
Ejecutar el Contenedor de Docker
Para ejecutar el contenedor de Docker, usa el siguiente comando:

```sh
docker run -d -p 80:80 -p 5432:5432 -v /ruta/a/tu/data:/var/lib/postgresql/data ghcr.io/cristopherpds/apache-python-postgre-img:latest
```


Reemplaza `/ruta/a/tu/data` con la ruta a tu directorio local donde deseas persistir los datos de PostgreSQL.

## Acceder a los Servicios

- **Apache**: El servidor Apache estará accesible en `http://localhost:80`.
- **PostgreSQL**: El servidor PostgreSQL estará accesible en `localhost:5432`.

## Credenciales Predeterminadas

- **PostgreSQL**:
  - Usuario: `postgres`
  - Contraseña: `password`

## Detener el Contenedor de Docker

Para detener el contenedor de Docker, usa el siguiente comando:

```sh
docker stop <id-del-contenedor>
```

Reemplaza `<id-del-contenedor>` con el ID real del contenedor en ejecución.

## Información Adicional

- El Dockerfile configura un entorno con Ubuntu, Apache, Python3 y PostgreSQL.
- Los puertos 80 (Apache) y 5432 (PostgreSQL) están expuestos.
- Los datos de PostgreSQL se persisten en el volumen `/var/lib/postgresql/data`.

No dudes en contactarme si tienes alguna pregunta o necesitas más ayuda.
```
