🛒 1. Productos más vendidos por volumen
Pregunta: ¿Cuáles son los productos más vendidos por volumen?

Atributos clave:

OrdenesProductos.ProductoID → ID del producto.

OrdenesProductos.Cantidad → Cantidad vendida por producto.

Productos.Nombre → Nombre del producto (opcional para visualización).

Relaciones:

OrdenesProductos.ProductoID → 🔑 foránea a Productos.ProductoID.

OrdenesProductos.OrdenID → 🔑 foránea a Ordenes.OrdenID.

💸 2. Ticket promedio por orden
Pregunta: ¿Cuál es el ticket promedio por orden?

Atributos clave:

Pagos.OrdenID

Pagos.Monto → Monto pagado.

Relaciones:

Pagos.OrdenID → 🔑 foránea a Ordenes.OrdenID.

🏷️ 3. Categorías con mayor número de productos vendidos
Pregunta: ¿Cuáles son las categorías con mayor número de productos vendidos?

Atributos clave:

OrdenesProductos.ProductoID

Productos.CategoriaID

OrdenesProductos.Cantidad

Categorias.Nombre (opcional).

Relaciones:

OrdenesProductos.ProductoID → Productos.ProductoID

Productos.CategoriaID → Categorias.CategoriaID

📅 4. Día de la semana con más ventas
Pregunta: ¿Qué día de la semana se generan más ventas?

Atributos clave:

Ordenes.Fecha

Relaciones:

No requiere joins si ya está la tabla Ordenes.

📈 5. Órdenes por mes y su variación
Pregunta: ¿Cuántas órdenes se generan cada mes y cuál es su variación?

Atributos clave:

Ordenes.Fecha

Ordenes.OrdenID

💳 6. Métodos de pago más utilizados
Pregunta: ¿Cuáles son los métodos de pago más utilizados?

Atributos clave:

Pagos.MetodoPagoID

MetodosPago.Nombre

Relaciones:

Pagos.MetodoPagoID → MetodosPago.MetodoPagoID

💰 7. Monto promedio por método de pago
Pregunta: ¿Cuál es el monto promedio pagado por método de pago?

Atributos clave:

Pagos.MetodoPagoID

Pagos.Monto

🧾 8. Órdenes pagadas con más de un método
Pregunta: ¿Cuántas órdenes se pagaron usando más de un método de pago?

Atributos clave:

Pagos.OrdenID

Pagos.MetodoPagoID

Agrupando por OrdenID y contando métodos distintos.

⏳ 9. Pagos 'Procesando' o 'Fallido'
Pregunta: ¿Cuántos pagos están en estado 'Procesando' o 'Fallido'?

Atributos clave:

Pagos.Estado

💵 10. Monto total recaudado por mes
Pregunta: ¿Cuál es el monto total recaudado por mes?

Atributos clave:

Pagos.Fecha

Pagos.Monto

👤 11. Usuarios registrados por mes
Pregunta: ¿Cuántos usuarios se registran por mes?

Atributos clave:

Usuarios.FechaRegistro

🔁 12. Usuarios con más de una orden
Pregunta: ¿Cuántos usuarios han realizado más de una orden?

Atributos clave:

Ordenes.UsuarioID

Relaciones:

Ordenes.UsuarioID → Usuarios.UsuarioID

🚫 13. Usuarios sin órdenes
Pregunta: ¿Cuántos usuarios registrados no han hecho ninguna compra?

Atributos clave:

Usuarios.UsuarioID

Ordenes.UsuarioID

**Un LEFT JOIN desde Usuarios a Ordenes y filtrar NULL.

💳 14. Usuarios que más gastaron
Pregunta: ¿Qué usuarios han gastado más en total?

Atributos clave:

Pagos.OrdenID → Ordenes.UsuarioID

Pagos.Monto

Relaciones:

Pagos.OrdenID → Ordenes.OrdenID

Ordenes.UsuarioID → Usuarios.UsuarioID

📝 15. Usuarios que dejaron reseñas
Pregunta: ¿Cuántos usuarios han dejado reseñas?

Atributos clave:

ReseñasProductos.UsuarioID

📦 16. Productos con alto stock y bajas ventas
Pregunta: ¿Qué productos tienen alto stock pero bajas ventas?

Atributos clave:

Productos.Stock

OrdenesProductos.ProductoID, Cantidad

❌ 17. Productos fuera de stock
Pregunta: ¿Cuántos productos están actualmente fuera de stock?

Atributos clave:

Productos.Stock = 0

👎 18. Productos peor calificados
Pregunta: ¿Cuáles son los productos peor calificados?

Atributos clave:

ReseñasProductos.ProductoID

ReseñasProductos.Calificacion

🗣️ 19. Productos con más reseñas
Pregunta: ¿Qué productos tienen mayor cantidad de reseñas?

Atributos clave:

ReseñasProductos.ProductoID

💸 20. Categoría con mayor valor económico vendido
Pregunta: ¿Qué categoría tiene el mayor valor económico vendido (no solo volumen)?

Atributos clave:

OrdenesProductos.ProductoID, Cantidad

Productos.Precio, CategoriaID

Categorias.Nombre