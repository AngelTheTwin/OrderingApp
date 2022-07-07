//
//  ProductoDAO.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import Foundation

class ProductoDAO {
    public static func getAllProductosGroupedByCategoria() async throws -> [Categoria] {
        let path = "categoria/getAllConProductos"
        let request = APIService.getRequest(method: .GET, path: path)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        let categorias = try JSONDecoder().decode([Categoria].self, from: data)
        return categorias
    }
}
