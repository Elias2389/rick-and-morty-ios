// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let characterListResponse = try? JSONDecoder().decode(CharacterListResponse.self, from: jsonData)

import Foundation

// MARK: - CharacterListResponse
struct CharacterListResponse: Codable {
    let info: InfoResponse
    let results: [CharacterResponse]
}

// MARK: - Info
struct InfoResponse: Codable {
    let count, pages: Int
    let next: String
    let prev: String
}

// MARK: - Result
struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: SpeciesResponse
    let type: String
    let gender: GenderResponse
    let origin, location: LocationResponse
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum GenderResponse: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationResponse: Codable {
    let name: String
    let url: String
}

enum SpeciesResponse: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
