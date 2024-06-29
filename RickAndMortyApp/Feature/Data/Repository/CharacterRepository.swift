//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 27/06/2024.
//

import Foundation

protocol CharacterRepository {
    func getCharacterList(pageNumber: String?) async throws -> CharacterListResponse
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListResponse
}

class CharacterListRepositoryImpl: CharacterRepository {
    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl()) {
        self.apiService = apiService
    }
    
    func getCharacterList(pageNumber: String?) async throws -> CharacterListResponse {
        do {
            let endpoint = RemoteUrl.baseUrl + RemoteUrl.characterUrl + "\(RemoteUrl.pagination)\(pageNumber ?? "1")"
            let response: CharacterListResponse = try await apiService.getDataFromAPI(from: endpoint)
            return response
        } catch {
            throw error
        }
    }
    
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListResponse {
        do {
            let endpoint = RemoteUrl.baseUrl + RemoteUrl.characterUrl + "\(RemoteUrl.name)"
            let response: CharacterListResponse = try await apiService.getDataFromAPI(from: endpoint)
            return response
        } catch {
            throw error
        }
    }
    
}
