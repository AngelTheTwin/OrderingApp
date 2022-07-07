//
//  Producto.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import Foundation

struct CategoriaProducto : Codable, Hashable {
    var nombre: String
}

struct Producto : Codable, Identifiable {
    var id: String {
        _id
    }
    var _id: String = ""
    var nombre: String = ""
    var descripcion: String = ""
    var precio: Double = 0.0
    var categoria: CategoriaProducto = CategoriaProducto(nombre: "")
    var imagen: String = ""
    var estado: String = ""
}
