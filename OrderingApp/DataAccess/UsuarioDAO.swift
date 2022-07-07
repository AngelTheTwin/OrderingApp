//
//  UsuarioDAO.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 28/06/22.
//

import Foundation
import CryptoKit

class UsuarioDAO {
    
    public static func login (_ usuario: LoginData) async throws -> Usuario? {
        let path = "usuario/login"
        var usuario = usuario
        usuario.contraseña = toHash(from: usuario.contraseña)
        let body: Data? =  try? JSONEncoder().encode(usuario)
        let request = APIService.getRequest(method: .POST, path: path, body: body)!
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            let respuesta = try JSONDecoder().decode(Respuesta.self, from: data)
            throw RequestError.wrongCredentials(mensaje: respuesta.mensaje!)
        }
        let loggedUsuario = try? JSONDecoder().decode(Usuario.self, from: data)
        return loggedUsuario
    }
    
    private static func toHash(from string: String) -> String {
        let inputData = Data(string.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
