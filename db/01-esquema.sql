SET NAMES utf8mb4;

CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  nif VARCHAR(20),
  email VARCHAR(150),
  telefono VARCHAR(30),
  direccion VARCHAR(255),
  fecha_alta DATE DEFAULT (CURRENT_DATE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE producto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10,2) NOT NULL,
  iva DECIMAL(5,2) NOT NULL DEFAULT 21
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE presupuesto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  numero VARCHAR(30) NOT NULL UNIQUE,
  fecha DATE NOT NULL,
  estado ENUM('pendiente','aceptado','rechazado') NOT NULL DEFAULT 'pendiente',
  base DECIMAL(10,2) DEFAULT 0,
  iva DECIMAL(10,2) DEFAULT 0,
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE linea_presupuesto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  presupuesto_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL DEFAULT 1,
  precio DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (presupuesto_id) REFERENCES presupuesto(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES producto(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- presupuesto_id es UNIQUE: un presupuesto solo puede pasar a una factura
CREATE TABLE factura (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  presupuesto_id INT UNIQUE,
  numero VARCHAR(30) NOT NULL UNIQUE,
  fecha DATE NOT NULL,
  estado ENUM('pendiente','pagada') NOT NULL DEFAULT 'pendiente',
  base DECIMAL(10,2) DEFAULT 0,
  iva DECIMAL(10,2) DEFAULT 0,
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id),
  FOREIGN KEY (presupuesto_id) REFERENCES presupuesto(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE linea_factura (
  id INT AUTO_INCREMENT PRIMARY KEY,
  factura_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL DEFAULT 1,
  precio DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (factura_id) REFERENCES factura(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES producto(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
