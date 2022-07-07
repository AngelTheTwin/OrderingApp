//
//  DireccionDAO.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import Foundation

class DireccionDAO {
    public static func createDireccion(_ direccion: Direccion, of usuario: Usuario) async throws -> Respuesta {
        let path = "direccion/create"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body: Data? = try? JSONEncoder().encode(direccion)
        let request = APIService.getRequest(method: .POST, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
    
    public static func readAllDirecciones(of usuario: Usuario) async throws -> [Direccion] {
        let path = "direccion/getAllByUsuario"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let request = APIService.getRequest(method: .GET, path: path, headers: headers)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.isSuccessful else {
            let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        let direcciones = try JSONDecoder().decode([Direccion].self, from: data)
        return direcciones
    }
    
    public static func updateDireccion(_ direccion: Direccion, of usuario: Usuario) async throws -> Respuesta {
        let path = "direccion/update"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body: Data? = try? JSONEncoder().encode(direccion)
        let request = APIService.getRequest(method: .PUT, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            print("Request responded with code \(httpResponse.statusCode)")
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
    
    public static func deleteDireccion(_ direccion: Direccion, of usuario: Usuario) async throws -> Respuesta {
        let path = "direccion/delete"
        var headers = [String: String]()
        headers["Authorization"] = "Bearer \(usuario.token)"
        let body = try? JSONEncoder().encode(direccion)
        let request = APIService.getRequest(method: .DELETE, path: path, headers: headers, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
        guard (httpResponse.isSuccessful) else {
            print("Request responded with code \(httpResponse.statusCode)")
            throw RequestError.serverError(mensaje: respuesta.error!)
        }
        return respuesta
    }
}
