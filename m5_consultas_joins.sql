
-- Motor utilizado: SQL Server
-- Base de datos: Ventas_Tech_DB
-- Pre-entrega 5: Consultas con JOINs
-- Proyecto: RetailPro

USE Ventas_Tech_DB;
GO

-- =====================================================
-- CONSULTA 1: INNER JOIN
-- Objetivo: Obtener una vista completa de las ventas,
-- incluyendo información de clientes, productos y categorías.
-- =====================================================

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- Hallazgo: Las 10 ventas registradas pueden analizarse
-- junto con los nombres de clientes, productos, categorías y ciudades.


-- =====================================================
-- CONSULTA 2: LEFT JOIN
-- Objetivo: Identificar clientes que todavía no realizaron
-- ninguna compra.
-- =====================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: No se encontraron clientes sin compras.
-- Los 5 clientes registrados realizaron al menos una venta.


-- =====================================================
-- CONSULTA 3: LEFT JOIN
-- Objetivo: Identificar productos que todavía no registraron
-- ninguna venta.
-- =====================================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: No se encontraron productos sin ventas.
-- Los 6 productos del catálogo registraron al menos una venta.


-- =====================================================
-- CONSULTA 4: UNION ALL
-- Objetivo: Comparar la facturación de la primera y segunda
-- parte de marzo de 2024.
-- =====================================================

SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Primera parte de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-01'
      AND fecha_venta < '2024-03-11'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Segunda parte de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'
      AND fecha_venta < '2024-04-01'
) AS consolidado
GROUP BY canal
ORDER BY canal;

-- Hallazgo: La primera parte de marzo generó $3.620,
-- mientras que la segunda parte generó $2.824.
-- La primera parte del mes registró una facturación mayor.

-- Motor utilizado: SQL Server
-- Base de datos: Ventas_Tech_DB
-- Pre-entrega 5: Consultas con JOINs
-- Proyecto: RetailPro

USE Ventas_Tech_DB;
GO

-- =====================================================
-- CONSULTA 1: INNER JOIN
-- Objetivo: Obtener una vista completa de las ventas,
-- incluyendo información de clientes, productos y categorías.
-- =====================================================

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- Hallazgo: Las 10 ventas registradas pueden analizarse
-- junto con los nombres de clientes, productos, categorías y ciudades.


-- =====================================================
-- CONSULTA 2: LEFT JOIN
-- Objetivo: Identificar clientes que todavía no realizaron
-- ninguna compra.
-- =====================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: No se encontraron clientes sin compras.
-- Los 5 clientes registrados realizaron al menos una venta.


-- =====================================================
-- CONSULTA 3: LEFT JOIN
-- Objetivo: Identificar productos que todavía no registraron
-- ninguna venta.
-- =====================================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: No se encontraron productos sin ventas.
-- Los 6 productos del catálogo registraron al menos una venta.


-- =====================================================
-- CONSULTA 4: UNION ALL
-- Objetivo: Comparar la facturación de la primera y segunda
-- parte de marzo de 2024.
-- =====================================================

SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Primera parte de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-01'
      AND fecha_venta < '2024-03-11'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Segunda parte de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'
      AND fecha_venta < '2024-04-01'
) AS consolidado
GROUP BY canal
ORDER BY canal;

-- Hallazgo: La primera parte de marzo generó $3.620,
-- mientras que la segunda parte generó $2.824.
-- La primera parte del mes registró una facturación mayor.
