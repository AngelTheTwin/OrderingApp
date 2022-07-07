//
//  MetodoPagoDAO.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 30/06/22.
//

import Foundation

class MetodoPagoDAO {
    public static func createMetodoPago(_ metodoPago: MetodoPago, of usuario: Usuario) async throws -> Respuesta {
        let path = "metodoPago/create"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body = try? JSONEncoder().encode(metodoPago)
        let request = APIService.getRequest(method: .POST, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
    
    public static func readAllMetodosPago(of usuario: Usuario) async throws -> [MetodoPago] {
        let path = "metodoPago/getAllByUsuario"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let request = APIService.getRequest(method: .GET, path: path, headers: headers)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard (httpResponse.isSuccessful) else {
            let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        let metodosPago = try JSONDecoder().decode([MetodoPago].self, from: data)
        return metodosPago
    }
    
    public static func updateMetodoPago(_ metodoPago: MetodoPago, of usuario: Usuario) async throws -> Respuesta {
        let path = "metodoPago/update"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body = try? JSONEncoder().encode(metodoPago)
        let request = APIService.getRequest(method: .PUT, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
    
    public static func deleteMetodoPago(_ metodoPago: MetodoPago, of usuario: Usuario) async throws -> Respuesta {
        let path = "metodoPago/delete"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body = try? JSONEncoder().encode(metodoPago)
        let request = APIService.getRequest(method: .DELETE, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
}
