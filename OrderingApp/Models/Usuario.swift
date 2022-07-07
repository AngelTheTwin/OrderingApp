//
//  Usuario.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 28/06/22.
//

import Foundation

class Usuario : Codable {
    var _id: String
    var nombre: String
    var apellido: String
    var correo: String
    var tipoUsuario: String
    var token: String
}
