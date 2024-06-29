//
//  Api.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 27/06/2024.
//

import Foundation

protocol ApiService {
    func getDataFromAPI<Response: Codable>(from url: String) async throws -> Response
}

class ApiServiceImpl: ApiService {
    func getDataFromAPI<Response: Codable>(from url: String) async throws -> Response {
        guard let url = URL(string: url) else {
            throw AppError.invalidUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            if (error as? DecodingError) != nil {
                throw AppError.parseError
            }
            
            throw AppError.serviceError(error: error)
        }
    }
    
}
