//
//  APIService.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 28/06/22.
//

import Foundation

final class APIService {
    private static let HOST = ProcessInfo.processInfo.environment["HOST"] ?? "angel.local"
    private static let PORT = 84
    
    private static func createRequest(for url: String) -> URLRequest {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func getRequest(method: HttpMethod, path: String, pathParams: [String: CustomStringConvertible] = [:], headers: [String:String] = [:], body: Data? = nil) -> URLRequest? {
        var url = "http://\(HOST):\(PORT)/\(path)"
        url = setPathParams(to: url, params: pathParams)
        var request = createRequest(for: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
    
    private static func setPathParams(to url: String, params: [String: CustomStringConvertible]) -> String {
        var resultado = url
        params.forEach { (key: String, value: CustomStringConvertible) in
            resultado = resultado.replacingOccurrences(of: "{\(key)}", with: value.description)
        }
        return resultado
    }
}

extension HTTPURLResponse {
    var isSuccessful: Bool {
        return self.statusCode >= 200 && self.statusCode < 300
    }
}

enum RequestError: Error {
    case incompleteData(mensaje: String)
    case wrongCredentials(mensaje: String)
    case serverError(mensaje: String)
}

extension RequestError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .incompleteData(let mensaje),
            .wrongCredentials(let mensaje),
            .serverError(let mensaje):
            return mensaje
        }
    }
}

struct Respuesta: Codable {
    var error: String?
    var mensaje: String?
}

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
