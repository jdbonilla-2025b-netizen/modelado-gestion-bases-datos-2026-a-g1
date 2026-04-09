-- DDL - Data Definition Language (Crear tablas)

CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
    id_producto  INT PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL,
    precio       DECIMAL(10,2) NOT NULL,
    stock        INT NOT NULL DEFAULT 0,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre     VARCHAR(100) NOT NULL,
    ciudad     VARCHAR(50),
    email      VARCHAR(100)
);

CREATE TABLE ventas (
    id_venta   INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha      DATE NOT NULL,
    total      DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_ventas (
    id_detalle  INT PRIMARY KEY AUTO_INCREMENT,
    id_venta    INT,
    id_producto INT,
    cantidad    INT NOT NULL,
    precio_unit DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta)    REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- DML - Data Manipulation Language (Insertar datos)


INSERT INTO categorias (nombre) VALUES
('Electrónica'),
('Ropa'),
('Alimentos'),
('Hogar');

INSERT INTO productos (nombre, precio, stock, id_categoria) VALUES
('Televisor 42"',   850000, 10, 1),
('Audífonos',        75000, 50, 1),
('Camiseta',         35000, 100, 2),
('Pantalón',         80000, 60, 2),
('Arroz x 5kg',      18000, 200, 3),
('Aceite x 1L',       9000, 150, 3),
('Lámpara LED',      45000, 30, 4),
('Silla de oficina', 320000, 15, 4);

INSERT INTO clientes (nombre, ciudad, email) VALUES
('Ana Gómez',    'Bogotá',    'ana@mail.com'),
('Luis Pérez',   'Medellín',  'luis@mail.com'),
('María Torres', 'Cali',      'maria@mail.com'),
('Carlos Ruiz',  'Bogotá',    'carlos@mail.com'),
('Sofía Lima',   'Barranquilla','sofia@mail.com');

INSERT INTO ventas (id_cliente, fecha, total) VALUES
(1, '2024-01-10', 925000),
(2, '2024-01-15', 110000),
(3, '2024-02-05',  27000),
(4, '2024-02-20', 400000),
(1, '2024-03-01',  45000),
(5, '2024-03-15', 320000),
(2, '2024-03-20',  53000),
(3, '2024-04-10', 160000);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unit) VALUES
(1, 1, 1, 850000),
(1, 2, 1,  75000),
(2, 3, 2,  35000),
(2, 4, 1,  80000),
(3, 5, 1,  18000),
(3, 6, 1,   9000),
(4, 8, 1, 320000),
(4, 3, 1,  35000),
(4, 7, 1,  45000),
(5, 7, 1,  45000),
(6, 8, 1, 320000),
(7, 5, 2,  18000),
(7, 6, 1,   9000),
(8, 4, 2,  80000);

-- FUNCIONES DE AGREGACIÓN: SUM, COUNT, AVG, MAX, MIN

-- Total de dinero vendido en toda la tienda
SELECT SUM(total) AS total_ventas
FROM ventas;

-- Número total de ventas realizadas
SELECT COUNT(*) AS cantidad_ventas
FROM ventas;

-- Promedio del valor de las ventas
SELECT AVG(total) AS promedio_ventas
FROM ventas;

-- Venta más alta y venta más baja
SELECT MAX(total) AS venta_maxima,
       MIN(total) AS venta_minima
FROM ventas;

-- Precio más alto y más bajo entre los productos
SELECT MAX(precio) AS precio_maximo,
       MIN(precio) AS precio_minimo
FROM productos;

-- GROUP BY - Agrupar resultados


-- Total de ventas por cliente
SELECT c.nombre, SUM(v.total) AS total_comprado
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre;

-- Cantidad de productos por categoría
SELECT cat.nombre AS categoria, COUNT(p.id_producto) AS cantidad_productos
FROM productos p
JOIN categorias cat ON p.id_categoria = cat.id_categoria
GROUP BY cat.nombre;

-- Total vendido por mes
SELECT MONTH(fecha) AS mes, SUM(total) AS total_mes
FROM ventas
GROUP BY MONTH(fecha)
ORDER BY mes;


-- HAVING - Filtrar grupos

-- Clientes que han comprado más de $200.000 en total
SELECT c.nombre, SUM(v.total) AS total_comprado
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre
HAVING SUM(v.total) > 200000;

-- Categorías con más de 2 productos
SELECT cat.nombre, COUNT(p.id_producto) AS cantidad
FROM productos p
JOIN categorias cat ON p.id_categoria = cat.id_categoria
GROUP BY cat.nombre
HAVING COUNT(p.id_producto) > 2;

-- ORDER BY - Ordenar resultados

-- Productos ordenados de mayor a menor precio
SELECT nombre, precio
FROM productos
ORDER BY precio DESC;

-- Ventas ordenadas por fecha (más reciente primero)
SELECT id_venta, fecha, total
FROM ventas
ORDER BY fecha DESC;

-- Clientes ordenados alfabéticamente
SELECT nombre, ciudad
FROM clientes
ORDER BY nombre ASC;


-- LIMIT - Limitar resultados

-- Los 3 productos más caros
SELECT nombre, precio
FROM productos
ORDER BY precio DESC
LIMIT 3;

-- Las 5 ventas más recientes
SELECT id_venta, fecha, total
FROM ventas
ORDER BY fecha DESC
LIMIT 5;

-- El cliente que más ha comprado (top 1)
SELECT c.nombre, SUM(v.total) AS total_comprado
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre
ORDER BY total_comprado DESC
LIMIT 1;


-- PROCEDIMIENTOS ALMACENADOS

DELIMITER $$

-- 1. INSERT: Registrar una nueva venta
CREATE PROCEDURE sp_insertar_venta(
    IN p_id_cliente INT,
    IN p_fecha      DATE,
    IN p_total      DECIMAL(10,2)
)
BEGIN
    INSERT INTO ventas (id_cliente, fecha, total)
    VALUES (p_id_cliente, p_fecha, p_total);
END$$

-- 2. UPDATE: Actualizar el stock de un producto
CREATE PROCEDURE sp_actualizar_stock(
    IN p_id_producto INT,
    IN p_nuevo_stock INT
)
BEGIN
    UPDATE productos
    SET stock = p_nuevo_stock
    WHERE id_producto = p_id_producto;
END$$

-- 3. DELETE: Eliminar una venta por ID
CREATE PROCEDURE sp_eliminar_venta(
    IN p_id_venta INT
)
BEGIN
    DELETE FROM detalle_ventas WHERE id_venta = p_id_venta;
    DELETE FROM ventas WHERE id_venta = p_id_venta;
END$$

-- 4. SELECT: Consultar ventas de un cliente específico
CREATE PROCEDURE sp_ventas_cliente(
    IN p_id_cliente INT
)
BEGIN
    SELECT v.id_venta, v.fecha, v.total
    FROM ventas v
    WHERE v.id_cliente = p_id_cliente
    ORDER BY v.fecha DESC;
END$$

DELIMITER ;


-- LLAMAR A LOS PROCEDIMIENTOS (ejemplos de uso)


-- Insertar una nueva venta
CALL sp_insertar_venta(3, '2024-05-01', 54000);

-- Actualizar stock del producto con id 1
CALL sp_actualizar_stock(1, 8);

-- Eliminar la venta con id 9 (la que acabamos de insertar)
CALL sp_eliminar_venta(9);

-- Ver todas las ventas del cliente con id 1
CALL sp_ventas_cliente(1);