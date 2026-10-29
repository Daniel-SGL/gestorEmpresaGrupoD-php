-- Datos de prueba para que cada grupo pueda trabajar sin esperar a los demás
SET NAMES utf8mb4;

INSERT INTO cliente (nombre, nif, email, telefono, direccion) VALUES
  ('Talleres López S.L.', 'B18000001', 'info@tallereslopez.es', '958111222', 'C/ Recogidas 12, Granada'),
  ('María García', '12345678A', 'maria@gmail.com', '600111222', 'C/ Mesones 5, Granada'),
  ('Panadería El Trigo', 'B18000002', 'eltrigo@gmail.com', '958333444', 'Av. Constitución 20, Granada');

INSERT INTO producto (nombre, descripcion, precio, iva) VALUES
  ('Diseño web', 'Diseño de una web corporativa', 600.00, 21),
  ('Hosting anual', 'Alojamiento web durante un año', 80.00, 21),
  ('Mantenimiento mensual', 'Actualizaciones y copias de seguridad', 40.00, 21),
  ('Hora de consultoría', 'Hora de asesoramiento técnico', 35.00, 21);

INSERT INTO presupuesto (cliente_id, numero, fecha, estado, base, iva, total) VALUES
  (1, 'P-2026-001', '2026-10-01', 'aceptado', 680.00, 142.80, 822.80),
  (2, 'P-2026-002', '2026-10-15', 'pendiente', 70.00, 14.70, 84.70);

INSERT INTO linea_presupuesto (presupuesto_id, producto_id, cantidad, precio) VALUES
  (1, 1, 1, 600.00),
  (1, 2, 1, 80.00),
  (2, 4, 2, 35.00);

INSERT INTO factura (cliente_id, presupuesto_id, numero, fecha, estado, base, iva, total) VALUES
  (1, 1, 'F-2026-001', '2026-10-05', 'pagada', 680.00, 142.80, 822.80);

INSERT INTO linea_factura (factura_id, producto_id, cantidad, precio) VALUES
  (1, 1, 1, 600.00),
  (1, 2, 1, 80.00);
