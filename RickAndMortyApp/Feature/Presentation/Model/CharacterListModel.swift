//
//  CharacterListModel.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 28/06/2024.
//

import Foundation

// MARK: - CharacterListResponse
struct CharacterListModel {
    let info: InfoModel
    let results: [CharacterModel]
    
    init(response: CharacterListResponse) {
        self.info = InfoModel(next: response.info.next, prev: response.info.prev)
        self.results = response.results.map({item in CharacterModel(response: item)})
    }
}

// MARK: - Info
struct InfoModel {
    let next: String
    let prev: String
    
    init(next: String = "", prev: String = "") {
        self.next = next
        self.prev = prev
    }
}

// MARK: - Result
struct CharacterModel {
    let id: Int
    let name: String
    let status: StatusModel?
    let species: SpeciesModel?
    let type: String
    let gender: GenderModel?
    let origin, location: LocationModel?
    let image: String
    let episodes: [String]
    let url: String
    let created: String
    
    var listOfEpisodes: String {
        episodes.compactMap{ URL(string: $0)?.lastPathComponent }.joined(separator: ", ")
    }
    
    init(response: CharacterResponse) {
        self.id = response.id
        self.name = response.name
        self.status = StatusModel(rawValue: response.status.rawValue)
        self.species = SpeciesModel(rawValue: response.species.rawValue)
        self.type = response.type
        self.gender = GenderModel(rawValue: response.gender.rawValue)
        self.origin = LocationModel(response: response.location)
        self.image = response.image
        self.episodes = response.episode
        self.url = response.url
        self.created = response.created
    }
}

// MARK: - Location
struct LocationModel: Codable {
    let name: String
    let url: String
    
    init(response: LocationResponse) {
        self.name = response.name
        self.url = response.url
    }
}

enum GenderModel: String {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

enum SpeciesModel: String {
    case alien = "Alien"
    case human = "Human"
}

enum StatusModel: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
