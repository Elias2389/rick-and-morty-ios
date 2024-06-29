//
//  CharacterUseCase.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 28/06/2024.
//

import Foundation

protocol CharacterUseCase {
    func getCharacterList(pageNumber: String?) async throws -> CharacterListModel
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListModel
}

class CharacterUseCaseImpl: CharacterUseCase {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterListRepositoryImpl()) {
        self.repository = repository
    }
    
    func getCharacterList(pageNumber: String?) async throws -> CharacterListModel {
        do {
            let response = try await repository.getCharacterList(pageNumber: pageNumber)
            return CharacterListModel(response: response)
        } catch {
            throw error
        }
    }
    
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListModel {
        do {
            let response = try await repository.searchCharacter(by: name, and: pageNumber)
            return CharacterListModel(response: response)
        } catch {
            throw error
        }
    }
}
