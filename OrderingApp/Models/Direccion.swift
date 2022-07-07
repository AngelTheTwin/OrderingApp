//
//  Direccion.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import Foundation

struct Direccion: Codable, Identifiable, Hashable {
    var id: String {
        _id
    }
    var _id: String = ""
    var titular: String = ""
    var calle: String = ""
    var colonia: String = ""
    var ciudad: String = ""
    var codigoPostal: String = ""
    var contacto: String = ""
    var estado: String = ""
    
    enum CodingKeys: CodingKey {
        case _id
        case titular
        case calle
        case colonia
        case ciudad
        case codigoPostal
        case contacto
        case estado
    }
}
