USE EcommerceDB;


-- Script para examinar los datos y detectar posibles inconsistencias en EcommerceDB

---------------------------------------------------------------------------------------------------
-- 1. Tabla Usuarios
---------------------------------------------------------------------------------------------------

-- Justificación: Identifica si hay usuarios con el mismo DNI, lo cual debería ser un identificador único.
SELECT DNI, COUNT(*)
FROM Usuarios
GROUP BY DNI
HAVING COUNT(*) > 1;


-- Justificación: Verifica si existen direcciones de correo electrónico duplicadas.
SELECT Email, COUNT(*)
FROM Usuarios
GROUP BY Email
HAVING COUNT(*) > 1;


---------------------------------------------------------------------------------------------------
-- 2. Tabla Categorias
---------------------------------------------------------------------------------------------------

-- Justificación: Busca categorías que tienen el mismo nombre.
SELECT Nombre, COUNT(*)
FROM Categorias
GROUP BY Nombre
HAVING COUNT(*) > 1;


---------------------------------------------------------------------------------------------------
-- 3. Tabla Productos
---------------------------------------------------------------------------------------------------

-- Justificación: Encuentra productos que comparten el mismo nombre, lo que podría indicar errores de entrada.
SELECT Nombre, COUNT(*)
FROM Productos
GROUP BY Nombre
HAVING COUNT(*) > 1;


-- Justificación: Identifica productos que están asociados a una categoría que no existe en la tabla Categorias (violación de integridad referencial).
SELECT p.*
FROM Productos p
LEFT JOIN Categorias c ON p.CategoriaID = c.CategoriaID
WHERE c.CategoriaID IS NULL;


-- Justificación: Detecta productos con valores inconsistentes en Precio o Stock (precios no pueden ser negativos o cero, stock no puede ser negativo).
SELECT *
FROM Productos
WHERE Precio <= 0 OR Stock < 0;


---------------------------------------------------------------------------------------------------
-- 4. Tabla Ordenes
---------------------------------------------------------------------------------------------------

-- Justificación: Encuentra órdenes que están vinculadas a un UsuarioID que no se encuentra en la tabla Usuarios (violación de integridad referencial).
SELECT o.*
FROM Ordenes o
LEFT JOIN Usuarios u ON o.UsuarioID = u.UsuarioID
WHERE u.UsuarioID IS NULL;


-- Justificación: Si tienes un conjunto de estados permitidos, esta consulta te ayudará a encontrar estados no válidos.
SELECT *
FROM Ordenes
WHERE Estado NOT IN ('Pendiente', 'Enviado', 'Completado', 'Cancelado');


---------------------------------------------------------------------------------------------------
-- 5. Tabla DetalleOrdenes
---------------------------------------------------------------------------------------------------

-- Justificación: Identifica registros de detalle que hacen referencia a una OrdenID que no existe en la tabla Ordenes (violación de integridad referencial).
SELECT do.*
FROM DetalleOrdenes do
LEFT JOIN Ordenes o ON do.OrdenID = o.OrdenID
WHERE o.OrdenID IS NULL;


-- Justificación: Encuentra registros de detalle que se refieren a un ProductoID que no existe en la tabla Productos (violación de integridad referencial).
SELECT do.*
FROM DetalleOrdenes do
LEFT JOIN Productos p ON do.ProductoID = p.ProductoID
WHERE p.ProductoID IS NULL;


-- Justificación: Detecta inconsistencias en la cantidad o el precio unitario de los productos en las órdenes (no pueden ser negativos o cero).
SELECT *
FROM DetalleOrdenes
WHERE Cantidad <= 0 OR PrecioUnitario <= 0;


-- Justificación: Comprueba si el Total de la orden en la tabla Ordenes coincide con la suma de (Cantidad * PrecioUnitario) de sus DetalleOrdenes, para detectar descuadres en el cálculo del total.
SELECT
    o.OrdenID,
    o.Total AS TotalOrden,
    SUM(do.Cantidad * do.PrecioUnitario) AS TotalCalculado
FROM Ordenes o
JOIN DetalleOrdenes do ON o.OrdenID = do.OrdenID
GROUP BY o.OrdenID, o.Total
HAVING o.Total <> SUM(do.Cantidad * do.PrecioUnitario);


---------------------------------------------------------------------------------------------------
-- 6. Tabla DireccionesEnvio
---------------------------------------------------------------------------------------------------

-- Justificación: Busca direcciones asociadas a un UsuarioID que no existe en la tabla Usuarios (violación de integridad referencial).
SELECT de.*
FROM DireccionesEnvio de
LEFT JOIN Usuarios u ON de.UsuarioID = u.UsuarioID
WHERE u.UsuarioID IS NULL;


-- Justificación: Identifica si un usuario tiene la misma dirección de envío registrada más de una vez (posible duplicidad de datos).
SELECT UsuarioID, Calle, Ciudad, Provincia, CodigoPostal, Pais, COUNT(*)
FROM DireccionesEnvio
GROUP BY UsuarioID, Calle, Ciudad, Provincia, CodigoPostal, Pais
HAVING COUNT(*) > 1;


---------------------------------------------------------------------------------------------------
-- 7. Tabla Carrito
---------------------------------------------------------------------------------------------------

-- Justificación: Detecta elementos en el carrito que pertenecen a un UsuarioID que no existe (violación de integridad referencial).
SELECT c.*
FROM Carrito c
LEFT JOIN Usuarios u ON c.UsuarioID = u.UsuarioID
WHERE u.UsuarioID IS NULL;


-- Justificación: Encuentra elementos en el carrito que hacen referencia a un ProductoID que no existe (violación de integridad referencial).
SELECT c.*
FROM Carrito c
LEFT JOIN Productos p ON c.ProductoID = p.ProductoID
WHERE p.ProductoID IS NULL;


-- Justificación: Identifica si hay productos en el carrito con una cantidad no válida (negativa o cero).
SELECT *
FROM Carrito
WHERE Cantidad <= 0;


---------------------------------------------------------------------------------------------------
-- 8. Tabla MetodosPago
---------------------------------------------------------------------------------------------------

-- Justificación: Busca métodos de pago con el mismo nombre (posible duplicidad).
SELECT Nombre, COUNT(*)
FROM MetodosPago
GROUP BY Nombre
HAVING COUNT(*) > 1;


---------------------------------------------------------------------------------------------------
-- 9. Tabla OrdenesMetodosPago
---------------------------------------------------------------------------------------------------

-- Justificación: Identifica registros de pago que se refieren a una OrdenID que no existe en la tabla Ordenes (violación de integridad referencial).
SELECT omp.*
FROM OrdenesMetodosPago omp
LEFT JOIN Ordenes o ON omp.OrdenID = o.OrdenID
WHERE o.OrdenID IS NULL;


-- Justificación: Encuentra registros de pago que se refieren a un MetodoPagoID que no existe en la tabla MetodosPago (violación de integridad referencial).
SELECT omp.*
FROM OrdenesMetodosPago omp
LEFT JOIN MetodosPago mp ON omp.MetodoPagoID = mp.MetodoPagoID
WHERE mp.MetodoPagoID IS NULL;


-- Justificación: Detecta montos pagados inconsistentes (negativos o cero).
SELECT *
FROM OrdenesMetodosPago
WHERE MontoPagado <= 0;


-- Justificación: Comprueba si la suma de los MontoPagado para una OrdenID coincide con el Total de esa orden en la tabla Ordenes, para verificar si todos los pagos cuadran con el total de la orden.
SELECT
    o.OrdenID,
    o.Total AS TotalOrden,
    SUM(omp.MontoPagado) AS TotalPagado
FROM Ordenes o
LEFT JOIN OrdenesMetodosPago omp ON o.OrdenID = omp.OrdenID
GROUP BY o.OrdenID, o.Total
HAVING o.Total <> SUM(omp.MontoPagado) OR SUM(omp.MontoPagado) IS NULL;


---------------------------------------------------------------------------------------------------
-- 10. Tabla ReseñasProductos
---------------------------------------------------------------------------------------------------

-- Justificación: Busca reseñas que fueron hechas por un UsuarioID que no existe (violación de integridad referencial).
SELECT rp.*
FROM ReseñasProductos rp
LEFT JOIN Usuarios u ON rp.UsuarioID = u.UsuarioID
WHERE u.UsuarioID IS NULL;


-- Justificación: Identifica reseñas que corresponden a un ProductoID que no existe (violación de integridad referencial).
SELECT rp.*
FROM ReseñasProductos rp
LEFT JOIN Productos p ON rp.ProductoID = p.ProductoID
WHERE p.ProductoID IS NULL;


-- Justificación: Detecta calificaciones que no están entre 1 y 5 (rango válido para calificaciones).
SELECT *
FROM ReseñasProductos
WHERE Calificacion < 1 OR Calificacion > 5;


-- Justificación: Encuentra si un usuario ha dejado más de una reseña para el mismo producto (posible duplicidad de reseñas).
SELECT UsuarioID, ProductoID, COUNT(*)
FROM ReseñasProductos
GROUP BY UsuarioID, ProductoID
HAVING COUNT(*) > 1;

---------------------------------------------------------------------------------------------------
-- 11. Tabla HistorialPagos
---------------------------------------------------------------------------------------------------

-- Justificación: Identifica registros en el historial de pagos que se refieren a una OrdenID que no existe en la tabla Ordenes (violación de integridad referencial).
SELECT hp.*
FROM HistorialPagos hp
LEFT JOIN Ordenes o ON hp.OrdenID = o.OrdenID
WHERE o.OrdenID IS NULL;

-- Justificación: Encuentra registros en el historial de pagos que se refieren a un MetodoPagoID que no existe en la tabla MetodosPago (violación de integridad referencial).
SELECT hp.*
FROM HistorialPagos hp
LEFT JOIN MetodosPago mp ON hp.MetodoPagoID = mp.MetodoPagoID
WHERE mp.MetodoPagoID IS NULL;

-- Justificación: Detecta montos pagados inconsistentes en el historial de pagos (negativos o cero).
SELECT *
FROM HistorialPagos
WHERE Monto <= 0;


-- Justificación: Si tienes un conjunto de estados de pago permitidos (ej. 'Pagado', 'Procesando', 'Fallido', 'Reembolsado'), esta consulta te ayudará a encontrar estados no válidos.
SELECT *
FROM HistorialPagos
WHERE EstadoPago NOT IN ('Pagado', 'Procesando', 'Fallido', 'Reembolsado');

-- Justificación: Verifica si el monto de un pago individual en HistorialPagos se alinea con el MontoPagado registrado en OrdenesMetodosPago para la misma orden y método de pago, ayudando a detectar discrepancias entre el registro de pago detallado y el resumen.
SELECT
    omp.OrdenID,
    omp.MetodoPagoID,
    omp.MontoPagado AS MontoEnOrdenesMetodosPago,
    hp.Monto AS MontoEnHistorialPagos
FROM OrdenesMetodosPago omp
JOIN HistorialPagos hp
    ON omp.OrdenID = hp.OrdenID
    AND omp.MetodoPagoID = hp.MetodoPagoID
WHERE omp.MontoPagado <> hp.Monto;