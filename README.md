# gestorEmpresa-php

Web en PHP para gestionar una empresa: clientes, productos, presupuestos y facturas.

## Reparto

| Grupo | Parte | Carpeta |
|-------|-------|---------|
| A | Clientes y productos | `src/clientes/`, `src/productos/` |
| B | Presupuestos | `src/presupuestos/` |
| C | Facturas | `src/facturas/` |

## Arrancar

```
cp .env.example .env
docker compose up -d --build
```

- Web: http://localhost:8080
- phpMyAdmin: http://localhost:8081

La base se crea con `db/01-esquema.sql` y `db/02-datos.sql` (datos de prueba). Para recrearla desde cero: `docker compose down -v`.

## Base de datos

```
cliente 1 ── N presupuesto 1 ── N linea_presupuesto N ── 1 producto
cliente 1 ── N factura     1 ── N linea_factura     N ── 1 producto
presupuesto 0..1 ── 1 factura
```

- El precio de cada línea se copia del producto al crearla, para que no cambie si luego cambia el producto.
- `base`, `iva` y `total` de presupuestos y facturas se calculan con PHP al guardar las líneas.

## Reglas

- Cada grupo toca **solo su carpeta**.
- `db/`, `src/config/`, `src/includes/` y `src/css/` son comunes: no se cambian en los forks. Si necesitáis algo, avisad.
- Usad la conexión de `src/config/db.php` (`$pdo`) y consultas preparadas.
- Cada página empieza con `require '../config/db.php';` y `require '../includes/header.php';` y termina con `require '../includes/footer.php';`.

## Cómo trabajar

1. Fork del repo (lo hace el líder del grupo y añade a su grupo como colaboradores).
2. Clonar el fork y añadir el repo original:
   ```
   git clone https://github.com/TU_USUARIO/gestorEmpresa-php.git
   cd gestorEmpresa-php
   git remote add upstream https://github.com/dromerCode/gestorEmpresa-php.git
   ```
3. Traer cambios del original a menudo:
   ```
   git fetch upstream
   git merge upstream/main
   ```
4. Entregar: push al fork y abrir un pull request al repo original.
