# Fudo Web API

## Levantar la aplicación localmente

1. Instala las dependencias necesarias:
    ```sh
    gem install rack webrick
    ```
2. Inicia la aplicación:
    ```sh
    rackup
    ```
    Por defecto estará disponible en [http://localhost:9292](http://localhost:9292).

## Levantar la aplicación con Docker

1. Construye la imagen:
    ```sh
    docker build -t rack-api .
    ```
2. Corre el contenedor:
    ```sh
    docker run -p 9292:9292 rack-api
    ```

## Testear la API usando `curl`

### Autenticación

```sh
curl -X POST http://localhost:9292/v1/auth \
  -H "Content-Type: application/json" \
  -d '{"user":"admin","password":"password123"}'
```

### Crear un producto (requiere autenticación)

```sh
curl -X POST http://localhost:9292/v1/products \
  -H "Authorization: Bearer valid_token"
```

### Listar productos (requiere autenticación)

```sh
curl -X GET http://localhost:9292/v1/products \
  -H "Authorization: Bearer valid_token"
```

### Obtener OpenAPI Spec

```sh
curl http://localhost:9292/v1/openapi.yaml
```

### Obtener autores

```sh
curl http://localhost:9292/v1/AUTHORS
```
### Probar respuesta comprimida con gzip

Puedes solicitar respuestas comprimidas agregando el header `Accept-Encoding: gzip`:

```sh
curl -H "Authorization: Bearer valid_token" \
    -H "Accept-Encoding: gzip" \
    --compressed \
    http://localhost:9292/v1/products
```

El flag `--compressed` le indica a `curl` que acepte y descomprima automáticamente la respuesta gzip.

## Ejemplos de autenticación usando `curl`

Puedes autenticarte usando usuario y contraseña, o bien usando un token Bearer si ya lo tienes.

#### Autenticación con usuario y contraseña

```sh
curl -X POST http://localhost:9292/v1/auth \
    -H "Content-Type: application/json" \
    -d '{"user":"admin","password":"password123"}'
```

La respuesta incluirá un token de autenticación:

```json
{
    "message": "Authenticated with user and password",
    "token": "valid_token"
}
```

#### Autenticación usando token Bearer

```sh
curl -X POST http://localhost:9292/v1/auth \
    -H "Authorization: Bearer valid_token"
```

La respuesta será:

```json
{
    "message": "Authenticated with token"
}
```

Si el token es inválido, recibirás:

```json
{
    "error": "Invalid token"
}
```