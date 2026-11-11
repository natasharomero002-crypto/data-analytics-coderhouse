-- Motor utilizado: SQL Server
-- Base de datos: Ventas_Tech_DB
-- Pre-entrega 4: Consultas SQL de negocio
-- RetailPro

USE Ventas_Tech_DB;
GO

-- =============================================
-- CONSULTA 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio
-- =============================================

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- =============================================
-- CONSULTA 2: Ranking de productos - Top 5
-- Unidades vendidas y total facturado por producto
-- =============================================

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- =============================================
-- CONSULTA 3: Clientes recurrentes
-- Clientes con más de un pedido
-- =============================================

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- =============================================
-- CONSULTA 4: Productos por encima/por debajo del promedio
-- El promedio se calcula sobre el total facturado de cada producto
-- =============================================

WITH facturacion_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
),
promedio_productos AS (
    SELECT
        AVG(total_facturado) AS promedio_facturacion
    FROM facturacion_producto
)
SELECT
    fp.id_producto,
    fp.total_facturado,
    pp.promedio_facturacion,
    CASE
        WHEN fp.total_facturado >= pp.promedio_facturacion THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_producto fp
CROSS JOIN promedio_productos pp
ORDER BY fp.total_facturado DESC;


-- =============================================
-- HALLAZGOS
-- =============================================

-- 1. En marzo de 2024 se registraron 10 pedidos,
-- con una facturación total de $6.444 y un ticket
-- promedio de $644,40.

-- 2. El producto 1 fue el que generó mayor facturación,
-- con $3.600, seguido por el producto 3, con $1.350.

-- 3. El promedio de facturación por producto fue de $1.074.
-- Los productos 1 y 3 superaron dicho promedio.
