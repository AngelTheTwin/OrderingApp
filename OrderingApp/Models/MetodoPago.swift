//
//  MetodoPago.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 30/06/22.
//

import Foundation

struct MetodoPago: Codable, Identifiable, Hashable, Equatable {
    var id: String {
        _id
    }
    var _id: String = ""
    var numeroTarjeta: String = ""
    var titular: String = ""
    var vigencia: String = ""
    var cvv: String = ""
    var estado: String = "activo"
    var vigenciaMes: String = "" {
        didSet {
            vigencia = vigenciaMes + vigenciaAño
        }
    }
    var vigenciaAño: String = "" {
        didSet {
            vigencia = vigenciaMes + vigenciaAño
        }
    }
    
    enum CodingKeys: CodingKey {
        case _id
        case numeroTarjeta
        case titular
        case vigencia
        case cvv
        case estado
        case vigenciaMes
        case vigenciaAño
    }
    
    init(
        _id: String = "",
        numeroTarjeta: String = "",
        titular: String = "",
        vigencia: String = "",
        cvv: String = "",
        estado: String = "activo",
        vigenciaMes: String = "",
        vigenciaAño: String = ""
    ) {
        self._id = _id
        self.numeroTarjeta = numeroTarjeta
        self.titular = titular
        self.vigencia = vigencia
        self.cvv = cvv
        self.estado = estado
        self.vigenciaMes = vigenciaMes
        self.vigenciaAño = vigenciaAño
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.numeroTarjeta = try container.decode(String.self, forKey: .numeroTarjeta)
        self.titular = try container.decode(String.self, forKey: .titular)
        self.vigencia = try container.decode(String.self, forKey: .vigencia)
        self.cvv = try container.decode(String.self, forKey: .cvv)
        self.estado = try container.decode(String.self, forKey: .estado)
        self.vigenciaMes = (try? container.decode(String.self, forKey: .vigenciaMes)) ?? String(vigencia.prefix(2))
        self.vigenciaAño = (try? container.decode(String.self, forKey: .vigenciaAño)) ?? String(vigencia.suffix(2))
    }
}
