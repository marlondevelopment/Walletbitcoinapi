
# Wallet Bitcoin API

Esta API es un sistema integral diseñado para la gestión de transacciones de Bitcoin y operaciones de usuarios. Permite a los usuarios consultar precios en tiempo real, realizar transacciones y administrar cuentas de usuario.


## Características

- Consulta de precios de Bitcoin en tiempo real.
- Gestión de usuarios incluyendo creación, consulta y actualización de datos.
- Manejo de transacciones de Bitcoin, permitiendo compras y ventas.


## Tecnologías usadas

- Ruby on Rails: Framework para el desarrollo del backend.
- PostgreSQL: Sistema de gestión de bases de datos.


## Configuración Inicial

### Requisitos

- Ruby 3.x
- Rails 7.x
- PostgreSQL



## Instalación

1. Clona el repositorio:

```bash
git clone git@github.com:marlondevelopment/Walletbitcoinapi.git
```

2. Instala las dependencias:

```bash
rails db:create
rails db:migrate
```

    
### Ejecución

Para iniciar el servidor, ejecuta:

```bash
  rails server
```


## Uso

Para comenzar a usar la API, registra un usuario y realiza las transacciones de acuerdo con los endpoints proporcionados en la documentación interna.


## APIs

## Usuarios

### Crear Usuario

Este endpoint permite registrar un nuevo usuario en el sistema.

### Request

`POST /api/v1/users`

#### Headers

| Header Key | Value          |
|------------|----------------|
| Content-Type | `application/json`  |

#### Body

```json
{
  "first_name": "Juan",
  "last_name": "Doe",
  "email": "juan.doe@example.com",
  "password": "password123"
}
```

### Response

```json
{
  "success": true,
  "message": "Usuario creado exitosamente",
  "data": {
    "id": 1,
    "first_name": "Juan",
    "last_name": "Doe",
    "email": "juan.doe@example.com"
  }
}
```

## Listar Usuarios

Este endpoint permite obtener un listado de todos los usuarios registrados en el sistema.

### Request

`GET /api/v1/users`

#### Query Parameters

| Parameter    | Type     | Description                                 |
|--------------|----------|---------------------------------------------|
| `page`       | `int`    | Opcional. Número de página para la paginación. |
| `per_page`   | `int`    | Opcional. Cantidad de usuarios por página.  |

### Response

#### Success Response

**Code:** `200 OK`

```json
{
  "success": true,
  "message": "Usuarios listados exitosamente",
  "data": [
    {
      "id": 1,
      "first_name": "Ana",
      "last_name": "García",
      "email": "ana.garcia@example.com"
    },
    {
      "id": 2,
      "first_name": "Luis",
      "last_name": "Martínez",
      "email": "luis.martinez@example.com"
    }
  ],
  "total_pages": 5,
  "current_page": 1
}
```

## Editar Usuario

Este endpoint permite actualizar la información de un usuario existente en el sistema.

### Request

`PUT /api/v1/users/{user_id}`

#### URL Parameters

| Parameter | Type     | Description                                  |
|-----------|----------|----------------------------------------------|
| `user_id` | `string` | **Required**. ID del usuario a actualizar.    |

#### Headers

| Header Key   | Value            |
|--------------|------------------|
| Content-Type | `application/json` |

#### Body

```json
{
  "first_name": "Carlos",
  "last_name": "Ramírez",
  "email": "carlos.ramirez@example.com",
  "balance": 25000
}
```
#### Success Response

**Code:** `200 OK`
```json
{
  "success": true,
  "message": "Usuario actualizado exitosamente",
  "data": {
    "id": 1,
    "first_name": "Carlos",
    "last_name": "Ramírez",
    "email": "carlos.ramirez@example.com",
    "balance": 25000
  }
}
```

## Detalle de Usuario

Este endpoint permite obtener la información detallada de un usuario específico registrado en el sistema.

### Request

`GET /api/v1/users/{user_id}`

#### URL Parameters

| Parameter | Type     | Description                           |
|-----------|----------|---------------------------------------|
| `user_id` | `string` | **Required**. ID del usuario a consultar. |

### Response

#### Success Response

**Code:** `200 OK`

```json
{
  "success": true,
  "message": "Detalle de usuario obtenido exitosamente",
  "data": {
    "id": 1,
    "first_name": "Carlos",
    "last_name": "Ramírez",
    "email": "carlos.ramirez@example.com",
    "balance": 25000
  }
}
```

## Transacciones

## Listar Transacciones de un Usuario

Este endpoint permite obtener una lista de todas las transacciones realizadas por un usuario específico.

### Request

`GET /api/v1/users/{user_id}/transactions`

#### URL Parameters

| Parameter | Type     | Description                                 |
|-----------|----------|---------------------------------------------|
| `user_id` | `string` | **Required**. ID del usuario cuyas transacciones se desean listar. |

#### Query Parameters (Opcionales)

| Parameter  | Type  | Description                                          |
|------------|-------|------------------------------------------------------|
| `page`     | `int` | Número de página para la paginación (por defecto, 1). |
| `per_page` | `int` | Cantidad de transacciones por página (por defecto, 10). |

### Response

#### Success Response

**Code:** `200 OK`

```json
{
  "success": true,
  "message": "Lista de transacciones obtenida exitosamente",
  "data": [
    {
      "id": 1,
      "transaction_type": "buy",
      "amount_sent": 1000,
      "currency_sent": "USD",
      "amount_received": 0.025,
      "currency_received": "BTC",
      "btc_price_at_transaction": 40000,
      "created_at": "2024-08-13T12:34:56Z"
    },
    {
      "id": 2,
      "transaction_type": "sell",
      "amount_sent": 0.01,
      "currency_sent": "BTC",
      "amount_received": 400,
      "currency_received": "USD",
      "btc_price_at_transaction": 40000,
      "created_at": "2024-08-14T15:12:23Z"
    }
  ],
  "total_pages": 2,
  "current_page": 1
}
```

## Detalle de Transacción

Este endpoint permite obtener los detalles de una transacción específica realizada por un usuario.

### Request

`GET /api/v1/users/{user_id}/transactions/{transaction_id}`

#### URL Parameters

| Parameter        | Type     | Description                                         |
|------------------|----------|-----------------------------------------------------|
| `user_id`        | `string` | **Required**. ID del usuario propietario de la transacción. |
| `transaction_id` | `string` | **Required**. ID de la transacción a consultar.     |

### Response

#### Success Response

**Code:** `200 OK`

```json
{
  "success": true,
  "message": "Detalle de transacción",
  "data": {
    "id": 1,
    "transaction_type": "buy",
    "amount_sent": 1000,
    "currency_sent": "USD",
    "amount_received": 0.025,
    "currency_received": "BTC",
    "btc_price_at_transaction": 40000,
    "created_at": "2024-08-13T12:34:56Z"
  }
}
```

## Obtener Precio Actual del Bitcoin

Este endpoint permite consultar el precio actual del Bitcoin en USD.

### Request

`GET /api/v1/bitcoin_price`

### Response

#### Success Response

**Code:** `200 OK`

```json
{
  "success": true,
  "message": "Precio actual del Bitcoin obtenido con éxito",
  "data": {
    "bitcoin_price": 45000.00
  }
}
```

## Crear Transacción

Este endpoint permite a un usuario realizar una transacción de compra o venta de Bitcoin.

### Request

`POST /api/v1/users/{user_id}/transactions`

#### URL Parameters

| Parameter  | Type     | Description                                    |
|------------|----------|------------------------------------------------|
| `user_id`  | `string` | **Required**. ID del usuario que realiza la transacción. |

#### Headers

| Header Key   | Value            |
|--------------|------------------|
| Content-Type | `application/json` |

#### Body

- **Ejemplo de Compra** (Comprando Bitcoin con USD):
  ```json
  {
    "amount_sent": 1000,
    "currency_sent": "USD",
    "currency_received": "BTC",
    "transaction_type": "buy"
  }
  ```
  ### Response

  #### Success Response

  **Code:** `200 OK`

  ```json
  {
    "success": true,
    "message": "Transacción de compra realizada con éxito",
    "data": {
        "id": 1,
        "amount_sent": 1000,
        "currency_sent": "USD",
        "amount_received": 0.025,
        "currency_received": "BTC",
        "btc_price_at_transaction": 40000,
        "transaction_type": "buy",
        "created_at": "2024-08-13T12:34:56Z"
    }
  }
  ```


- **Ejemplo de Venta** (Vendiendo Bitcoin para recibir USD):
  ```json
  {
    "amount_sent": 0.05,
    "currency_sent": "BTC",
    "currency_received": "USD",
    "transaction_type": "sell"
  }
  ```

  ### Response

  #### Success Response

  **Code:** `200 OK`

  ```json
  {
    "success": true,
    "message": "Transacción de venta realizada con éxito",
    "data": {
        "id": 2,
        "amount_sent": 0.05,
        "currency_sent": "BTC",
        "amount_received": 2000,
        "currency_received": "USD",
        "btc_price_at_transaction": 40000,
        "transaction_type": "sell",
        "created_at": "2024-08-14T15:12:23Z"
    }
  }
  ```
- **Ejemplo de Compra** (Intentando comprar Bitcoin con USD, pero con saldo insuficiente):
  ```json
  {
    "amount_sent": 10000,
    "currency_sent": "USD",
    "currency_received": "BTC",
    "transaction_type": "buy"
  }
  ```
   ### Response

  #### Success Response

  **Code:** `200 OK`

  ```json
  {
    "success": false,
    "message": "Saldo insuficiente",
    "data": null,
    "status": 40
  }
  ```