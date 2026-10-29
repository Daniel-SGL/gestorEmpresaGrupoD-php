SET NAMES utf8mb4;

CREATE TABLE empresa (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  cif VARCHAR(20),
  direccion VARCHAR(255),
  email VARCHAR(150),
  telefono VARCHAR(30),
  logo VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE rol (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  permisos TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE usuario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  rol_id INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  activo BOOLEAN DEFAULT TRUE,
  ultimo_acceso DATETIME,
  FOREIGN KEY (empresa_id) REFERENCES empresa(id),
  FOREIGN KEY (rol_id) REFERENCES rol(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  tipo ENUM('particular','empresa') NOT NULL DEFAULT 'particular',
  nombre_fiscal VARCHAR(150) NOT NULL,
  nif_cif VARCHAR(20),
  email VARCHAR(150),
  telefono VARCHAR(30),
  notas TEXT,
  fecha_alta DATE DEFAULT (CURRENT_DATE),
  activo BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (empresa_id) REFERENCES empresa(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE direccion (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  tipo ENUM('fiscal','envio') NOT NULL DEFAULT 'fiscal',
  calle VARCHAR(255),
  ciudad VARCHAR(100),
  cp VARCHAR(10),
  provincia VARCHAR(100),
  pais VARCHAR(100) DEFAULT 'España',
  FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE contacto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  cargo VARCHAR(100),
  email VARCHAR(150),
  telefono VARCHAR(30),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE categoria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE impuesto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  porcentaje DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE producto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  categoria_id INT,
  impuesto_id INT NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10,2) NOT NULL,
  tipo ENUM('producto','servicio') NOT NULL DEFAULT 'servicio',
  activo BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (categoria_id) REFERENCES categoria(id),
  FOREIGN KEY (impuesto_id) REFERENCES impuesto(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE presupuesto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  usuario_id INT NOT NULL,
  numero VARCHAR(30) NOT NULL UNIQUE,
  fecha DATE NOT NULL,
  validez_hasta DATE,
  estado ENUM('borrador','enviado','aceptado','rechazado','caducado') NOT NULL DEFAULT 'borrador',
  base_imponible DECIMAL(10,2) DEFAULT 0,
  total_iva DECIMAL(10,2) DEFAULT 0,
  total DECIMAL(10,2) DEFAULT 0,
  condiciones TEXT,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE linea_presupuesto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  presupuesto_id INT NOT NULL,
  producto_id INT,
  descripcion VARCHAR(255) NOT NULL,
  cantidad DECIMAL(10,2) NOT NULL DEFAULT 1,
  precio_unitario DECIMAL(10,2) NOT NULL,
  descuento DECIMAL(5,2) DEFAULT 0,
  subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (presupuesto_id) REFERENCES presupuesto(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES producto(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE serie_factura (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prefijo VARCHAR(10) NOT NULL,
  ultimo_numero INT NOT NULL DEFAULT 0,
  anio INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE factura (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  usuario_id INT NOT NULL,
  presupuesto_id INT,
  serie_id INT NOT NULL,
  rectifica_id INT,
  numero VARCHAR(30) NOT NULL UNIQUE,
  fecha_emision DATE NOT NULL,
  fecha_vencimiento DATE,
  estado ENUM('borrador','emitida','pagada','vencida','anulada') NOT NULL DEFAULT 'borrador',
  base_imponible DECIMAL(10,2) DEFAULT 0,
  total_iva DECIMAL(10,2) DEFAULT 0,
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id),
  FOREIGN KEY (presupuesto_id) REFERENCES presupuesto(id),
  FOREIGN KEY (serie_id) REFERENCES serie_factura(id),
  FOREIGN KEY (rectifica_id) REFERENCES factura(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE linea_factura (
  id INT AUTO_INCREMENT PRIMARY KEY,
  factura_id INT NOT NULL,
  producto_id INT,
  descripcion VARCHAR(255) NOT NULL,
  cantidad DECIMAL(10,2) NOT NULL DEFAULT 1,
  precio_unitario DECIMAL(10,2) NOT NULL,
  descuento DECIMAL(5,2) DEFAULT 0,
  iva DECIMAL(5,2) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (factura_id) REFERENCES factura(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES producto(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE metodo_pago (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE pago (
  id INT AUTO_INCREMENT PRIMARY KEY,
  factura_id INT NOT NULL,
  metodo_id INT NOT NULL,
  fecha DATE NOT NULL,
  importe DECIMAL(10,2) NOT NULL,
  referencia VARCHAR(100),
  FOREIGN KEY (factura_id) REFERENCES factura(id),
  FOREIGN KEY (metodo_id) REFERENCES metodo_pago(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE adjunto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tipo_documento ENUM('presupuesto','factura') NOT NULL,
  documento_id INT NOT NULL,
  ruta VARCHAR(255) NOT NULL,
  nombre VARCHAR(150)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE log_actividad (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT,
  accion VARCHAR(50) NOT NULL,
  entidad VARCHAR(50),
  entidad_id INT,
  fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Datos iniciales
INSERT INTO impuesto (nombre, porcentaje) VALUES ('IVA 21%',21),('IVA 10%',10),('IVA 4%',4),('Exento',0);
INSERT INTO rol (nombre) VALUES ('admin'),('comercial'),('contable');
INSERT INTO metodo_pago (nombre) VALUES ('Efectivo'),('Transferencia'),('Tarjeta'),('Bizum');
INSERT INTO empresa (nombre, cif) VALUES ('Mi Empresa S.L.','B00000000');
INSERT INTO serie_factura (prefijo, ultimo_numero, anio) VALUES ('F',0,YEAR(CURDATE()));
