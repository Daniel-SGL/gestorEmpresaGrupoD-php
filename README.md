# gestorEmpresa-php

Web en PHP para gestionar una empresa: clientes, presupuestos y facturas.

## Arrancar

```
cp .env.example .env
docker compose up -d --build
```

- Web: http://localhost:8080
- phpMyAdmin: http://localhost:8081

La base se crea con `db/init.sql`. Si lo cambias, recréala con `docker compose down -v`.
