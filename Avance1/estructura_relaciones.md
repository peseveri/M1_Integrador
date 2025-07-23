# 📦 Modelo de Datos EcommerceDB + Preguntas de Negocio

---

## 🧱 Tablas (PK y FK)

### Usuarios
- `UsuarioID` (PK)

### Categorias
- `CategoriaID` (PK)

### Productos
- `ProductoID` (PK)
- `CategoriaID` (FK → Categorias.CategoriaID)

### Ordenes
- `OrdenID` (PK)
- `UsuarioID` (FK → Usuarios.UsuarioID)

### DetalleOrdenes
- `DetalleID` (PK)
- `OrdenID` (FK → Ordenes.OrdenID)
- `ProductoID` (FK → Productos.ProductoID)

### DireccionesEnvio
- `DireccionID` (PK)
- `UsuarioID` (FK → Usuarios.UsuarioID)

### Carrito
- `CarritoID` (PK)
- `UsuarioID` (FK → Usuarios.UsuarioID)
- `ProductoID` (FK → Productos.ProductoID)

### MetodosPago
- `MetodoPagoID` (PK)

### OrdenesMetodosPago
- `OrdenMetodoID` (PK)
- `OrdenID` (FK → Ordenes.OrdenID)
- `MetodoPagoID` (FK → MetodosPago.MetodoPagoID)

### ReseñasProductos
- `ReseñaID` (PK)
- `UsuarioID` (FK → Usuarios.UsuarioID)
- `ProductoID` (FK → Productos.ProductoID)

### HistorialPagos
- `PagoID` (PK)
- `OrdenID` (FK → Ordenes.OrdenID)
- `MetodoPagoID` (FK → MetodosPago.MetodoPagoID)

---

## ❓ Preguntas de Negocio + Atributos Clave + Relaciones

### 🛒 1. Productos más vendidos por volumen
- **Atributos:** `DetalleOrdenes.ProductoID`, `DetalleOrdenes.Cantidad`, `Productos.Nombre`
- **Relaciones:**
  - `DetalleOrdenes.ProductoID → Productos.ProductoID`
  - `DetalleOrdenes.OrdenID → Ordenes.OrdenID`

---

### 💸 2. Ticket promedio por orden
- **Atributos:** `OrdenesMetodosPago.OrdenID`, `OrdenesMetodosPago.MontoPagado`
- **Relaciones:** `OrdenesMetodosPago.OrdenID → Ordenes.OrdenID`

---

### 🏷️ 3. Categorías con mayor número de productos vendidos
- **Atributos:** `DetalleOrdenes.ProductoID`, `Productos.CategoriaID`, `DetalleOrdenes.Cantidad`, `Categorias.Nombre`
- **Relaciones:**
  - `DetalleOrdenes.ProductoID → Productos.ProductoID`
  - `Productos.CategoriaID → Categorias.CategoriaID`

---

### 📅 4. Día de la semana con más ventas
- **Atributos:** `Ordenes.FechaOrden`

---

### 📈 5. Órdenes por mes y su variación
- **Atributos:** `Ordenes.FechaOrden`, `Ordenes.OrdenID`

---

### 💳 6. Métodos de pago más utilizados
- **Atributos:** `OrdenesMetodosPago.MetodoPagoID`, `MetodosPago.Nombre`
- **Relaciones:** `OrdenesMetodosPago.MetodoPagoID → MetodosPago.MetodoPagoID`

---

### 💰 7. Monto promedio por método de pago
- **Atributos:** `OrdenesMetodosPago.MetodoPagoID`, `OrdenesMetodosPago.MontoPagado`

---

### 🧾 8. Órdenes pagadas con más de un método
- **Atributos:** `OrdenesMetodosPago.OrdenID`, `OrdenesMetodosPago.MetodoPagoID`
- **Agrupación:** contar métodos distintos por `OrdenID`

---

### ⏳ 9. Pagos 'Procesando' o 'Fallido'
- **Atributos:** `HistorialPagos.EstadoPago`

---

### 💵 10. Monto total recaudado por mes
- **Atributos:** `HistorialPagos.FechaPago`, `HistorialPagos.Monto`

---

### 👤 11. Usuarios registrados por mes
- **Atributos:** `Usuarios.FechaRegistro`

---

### 🔁 12. Usuarios con más de una orden
- **Atributos:** `Ordenes.UsuarioID`
- **Relaciones:** `Ordenes.UsuarioID → Usuarios.UsuarioID`

---

### 🚫 13. Usuarios sin órdenes
- **Atributos:** `Usuarios.UsuarioID`, `Ordenes.UsuarioID`
- **Relación lógica:** `LEFT JOIN Usuarios → Ordenes` y filtrar `Ordenes.UsuarioID IS NULL`

---

### 💳 14. Usuarios que más gastaron
- **Atributos:** `Ordenes.UsuarioID`, `OrdenesMetodosPago.MontoPagado`
- **Relaciones:**
  - `OrdenesMetodosPago.OrdenID → Ordenes.OrdenID`
  - `Ordenes.UsuarioID → Usuarios.UsuarioID`

---

### 📝 15. Usuarios que dejaron reseñas
- **Atributos:** `ReseñasProductos.UsuarioID`

---

### 📦 16. Productos con alto stock y bajas ventas
- **Atributos:** `Productos.Stock`, `DetalleOrdenes.ProductoID`, `DetalleOrdenes.Cantidad`

---

### ❌ 17. Productos fuera de stock
- **Atributos:** `Productos.Stock = 0`

---

### 👎 18. Productos peor calificados
- **Atributos:** `ReseñasProductos.ProductoID`, `ReseñasProductos.Calificacion`

---

### 🗣️ 19. Productos con más reseñas
- **Atributos:** `ReseñasProductos.ProductoID`

---

### 💸 20. Categoría con mayor valor económico vendido
- **Atributos:** `DetalleOrdenes.ProductoID`, `DetalleOrdenes.Cantidad`, `Productos.Precio`, `Productos.CategoriaID`, `Categorias.Nombre`
- **Relaciones:**
  - `DetalleOrdenes.ProductoID → Productos.ProductoID`
  - `Productos.CategoriaID → Categorias.CategoriaID`

---
