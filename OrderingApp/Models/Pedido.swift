//
//  Pedido.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 05/07/22.
//

import Foundation

struct Pedido: Identifiable, Codable {
    var id: String {
        _id
    }
    var _id: String = ""
    var productos: [Orden] = []
    var total: Double = 0.0
    var metodoPago: MetodoPago = MetodoPago()
    var direccion: Direccion = Direccion()
    var estado: EstadoPedido = .enCamino
    var fecha: Date = Date()
    var usuario: String = ""
    var repartidor: String? = nil
    
    
    var formattedTotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: total as NSNumber)!
    }
    
    enum CodingKeys: CodingKey {
        case _id
        case productos
        case total
        case metodoPago
        case direccion
        case estado
        case fecha
        case usuario
        case repartidor
    }
}
