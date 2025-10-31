//
//  ApiService.swift
//  PokeTest
//
//  Created by narek on 31.10.25.
//

import Foundation

protocol Endpoint {
    var rawValue: String { get }
}

protocol ApiServiceProtocol {
    var baseUrl: String {get set}
    func get<T: Codable>(endpoint: Endpoint) async -> T?
}

class ApiService: ApiServiceProtocol {
    var baseUrl: String
    private var urlSession: URLSession
    
    init(baseUrl: String, urlSession: URLSession = .shared) {
        self.baseUrl = baseUrl
        self.urlSession = urlSession
    }
    
    func get<T>(endpoint: Endpoint) async -> T? where T : Decodable, T : Encodable {
        var result: T?
        guard let url = URL(string: baseUrl + endpoint.rawValue) else {
            return result
        }
        do {
            let (data, _) = try await urlSession.data(for: URLRequest(url: url))
            let decoder = JSONDecoder()
            result = try decoder.decode(T.self, from: data)
        } catch {
//            print(error.localizedDescription)
        }
        return result
    }

}
