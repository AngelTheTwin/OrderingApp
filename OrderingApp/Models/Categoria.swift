//
//  Categoria.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import Foundation

struct Categoria : Codable, Identifiable {
    var id: String {
        _id
    }
    var _id: String = ""
    var nombre: String = ""
    var descripcion: String = ""
    var productos: [Producto] = []
}
