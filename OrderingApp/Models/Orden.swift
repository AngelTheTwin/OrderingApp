//
//  Orden.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 01/07/22.
//

import Foundation

struct Orden: Identifiable, Codable {
    var id = UUID()
    var _id: String = ""
    var platillo: Producto = Producto()
    var cantidad: Int = 0 {
        didSet {
            if (cantidad < 1) {
                cantidad = 1
            }
        }
    }
    var instruccionesEspeciales: String = ""
    
    var total: Double {
        platillo.precio * Double(cantidad)
    }
    
    var formattedTotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: total as NSNumber)!
    }
    
    enum CodingKeys: CodingKey {
        case _id
        case platillo
        case cantidad
        case instruccionesEspeciales
    }
}
