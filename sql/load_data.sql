
USE EcommerceDB;

-- SHOW VARIABLES LIKE 'secure_file_priv';  descomentar esto para ver la ruta en donde debo dejar los csv para que se puedan cargar exitosamente

-- 2 Usuarios.csv

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2.Usuarios.csv'
INTO TABLE Usuarios
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Apellido, DNI, Email, Contraseña);

-- 3.Categorias.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/3.Categorias.csv'
INTO TABLE Categorias
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Descripcion);

-- 4.Productos.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4.Productos.csv'
INTO TABLE Productos
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Descripcion, Precio, Stock, CategoriaID);

-- 5.ordenes.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/5.ordenes.csv'
INTO TABLE Ordenes
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(UsuarioID, FechaOrden, Total, Estado);

-- 6.detalle_ordenes.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/6.detalle_ordenes.csv'
INTO TABLE DetalleOrdenes
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrdenID, ProductoID, Cantidad, PrecioUnitario);

-- 7.direcciones_envio.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/7.direcciones_envio.csv'
INTO TABLE DireccionesEnvio
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(UsuarioID, Calle, Ciudad, Departamento, Provincia, Distrito, Estado, CodigoPostal, Pais);

-- 8.carrito.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/8.carrito.csv'
INTO TABLE Carrito
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(UsuarioID, ProductoID, Cantidad, FechaAgregado);

-- 9.metodos_pago.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/9.metodos_pago.csv'
INTO TABLE MetodosPago
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Descripcion);

-- 10.ordenes_metodospago.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/10.ordenes_metodospago.csv'
INTO TABLE OrdenesMetodosPago
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrdenID, MetodoPagoID, MontoPagado);

-- 11.resenas_productos.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/11.resenas_productos.csv'
INTO TABLE ReseñasProductos
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(UsuarioID, ProductoID, Calificacion, Comentario, Fecha);

-- 12.historial_pagos.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/12.historial_pagos.csv'
INTO TABLE HistorialPagos
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrdenID, MetodoPagoID, Monto, FechaPago, EstadoPago);
