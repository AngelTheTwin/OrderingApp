//
//  PreviewItems.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import Foundation

var categoriaProductoPreview = CategoriaProducto(nombre: "Italiana")

var productoPreview1 = Producto(
    _id: "62a059515ceb696bfbe74574",
    nombre: "Calzone",
    descripcion: "Especialidad de la cocina italiana elaborada de forma similar a la pizza pero completamente cerrada por una masa; puede estar relleno de queso, carne, vegetales u otros condimentos, y se cocina al horno.",
    precio: 140.0,
    categoria: categoriaProductoPreview,
    imagen: "https://media.istockphoto.com/photos/crispy-pita-pocket-bread-filled-with-shaved-kebab-meat-vegetable-and-picture-id1289477713",
    estado: "activo"
)

var productoPreview2 = Producto(
    _id: "62a059515ceb696bfbe74575",
    nombre: "Pizza Hawaiana",
    descripcion: "La pizza que unos cuestionan pero todos aman. Jamón, piña.",
    precio: 180.0,
    categoria: categoriaProductoPreview,
    imagen: "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    estado: "activo"
)

var productoPreview3 = Producto(
    _id: "62a059515ceb696bfbe74576",
    nombre: "Pizza de Pepperoni Especial",
    descripcion: "La combinación perfecta entre Pepperoni y Champiñones, con un gran sabor y horneado al momento.",
    precio: 190.0,
    categoria: categoriaProductoPreview,
    imagen: "https://images.unsplash.com/photo-1541745537411-b8046dc6d66c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80",
    estado: "activo"
)

var categoriaPreview = Categoria(_id: "62a05d4a55034169df6df2f4", nombre: "Italiana", descripcion: "La Pizza, el risotto, muchas formas de pasta, la parmigiana, la frittata, el gelato o el tiramisú..", productos: [productoPreview1, productoPreview2, productoPreview3])

var ordenPreview1 = Orden(platillo: productoPreview1, cantidad: 3)

var ordenPreview2 = Orden(platillo: productoPreview2, cantidad: 3, instruccionesEspeciales: "Con extra queso 🧀")

var carritoPreview = [ordenPreview1, ordenPreview2]

var direccionPreview1 = Direccion(
    _id: "62a6c41a51f6e51d524e3870",
    titular: "Jeffrey Tapia",
    calle: "Laureles #35",
    colonia: "Sumidero",
    ciudad: "Xalapa",
    codigoPostal: "91150",
    contacto: "+522281454587",
    estado: "activo"
)

var direccionPreview2 = Direccion(
    _id: "62a7ed12c773c07091a69871",
    titular: "Daniel García",
    calle: "Prof Adalberto Lara Hernandez",
    colonia: "Aguacatal",
    ciudad: "Xalapa",
    codigoPostal: "91130",
    contacto: "+522281245454",
    estado: "activo"
)

var direccionesPreview = [direccionPreview1, direccionPreview2]

var cardPreview1 = MetodoPago(_id: "62aa7e3c49a41de05cae1aac", numeroTarjeta: "6054598797799879", titular: "Daniel garcía", vigencia: "4545", cvv: "4545", vigenciaMes: "02", vigenciaAño: "26")

var cardPreview2 = MetodoPago(_id: "62a921047aa82a40961dcdfc", numeroTarjeta: "5032365654579798", titular: "Angel Sánchez", vigencia: "1226", cvv: "5656", vigenciaMes: "12", vigenciaAño: "26")

var metodosPagoPreview = [cardPreview1, cardPreview2]

var pedidoPreview = Pedido(_id: "62a6cdb151b43c0fe1e35deb", productos: carritoPreview, total: 50, metodoPago: cardPreview1, direccion: direccionPreview1, estado: .enProceso, fecha: Date(), usuario: "idusuario", repartidor: nil)
