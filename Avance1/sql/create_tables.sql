-- Crear base de datos
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Contraseña VARCHAR(255) NOT NULL,
    FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Categorías
CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- Tabla: Productos
CREATE TABLE Productos (
    ProductoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Tabla: Órdenes
CREATE TABLE Ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT,
    FechaOrden DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(50) DEFAULT 'Pendiente',
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla: Detalle de Órdenes
CREATE TABLE DetalleOrdenes (
    DetalleID INT AUTO_INCREMENT PRIMARY KEY,
    OrdenID INT,
    ProductoID INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Tabla: Direcciones de Envío
CREATE TABLE DireccionesEnvio (
    DireccionID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT,
    Calle VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Departamento VARCHAR(100),
    Provincia VARCHAR(100),
    Distrito VARCHAR(100),
    Estado VARCHAR(100),
    CodigoPostal VARCHAR(20),
    Pais VARCHAR(100) NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla: Carrito de Compras
CREATE TABLE Carrito (
    CarritoID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT,
    ProductoID INT,
    Cantidad INT NOT NULL,
    FechaAgregado DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Tabla: Métodos de Pago
CREATE TABLE MetodosPago (
    MetodoPagoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- Tabla: Ordenes Métodos de Pago
CREATE TABLE OrdenesMetodosPago (
    OrdenMetodoID INT AUTO_INCREMENT PRIMARY KEY,
    OrdenID INT,
    MetodoPagoID INT,
    MontoPagado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodosPago(MetodoPagoID)
);

-- Tabla: Reseñas de Productos
CREATE TABLE ReseñasProductos (
    ReseñaID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT,
    ProductoID INT,
    Calificacion INT CHECK (Calificacion >= 1 AND Calificacion <= 5),
    Comentario TEXT,
    Fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Tabla: Historial de Pagos
CREATE TABLE HistorialPagos (
    PagoID INT AUTO_INCREMENT PRIMARY KEY,
    OrdenID INT,
    MetodoPagoID INT,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME DEFAULT CURRENT_TIMESTAMP,
    EstadoPago VARCHAR(50) DEFAULT 'Procesando',
    FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodosPago(MetodoPagoID)
);
