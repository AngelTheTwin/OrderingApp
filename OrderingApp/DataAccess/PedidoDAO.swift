//
//  PedidoDAO.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 05/07/22.
//

import Foundation

class PedidoDAO {
    public static func createPedido(_ pedido: Pedido, of usuario: Usuario) async throws -> Respuesta {
        let path = "pedido/create"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body = try? JSONEncoder().encode(pedido)
        let request = APIService.getRequest(method: .POST, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
    
    public static func readAllPedidos(of usuario: Usuario) async throws -> [Pedido] {
        let path = "pedido/getAllByUsuario"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let request = APIService.getRequest(method: .GET, path: path, headers: headers)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.isSuccessful else {
            let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601)
        let pedidos = try decoder.decode([Pedido].self, from: data)
        return pedidos
    }
}
