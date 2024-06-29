//
//  AppError.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 27/06/2024.
//

import Foundation

let APP_ERROR: String = "APP-ERROR"

enum AppError: Error {
    case serviceError(error: Error)
    case invalidUrl
    case missingData
    case unExpectedError
    case parseError
}

extension AppError {
    var errorDescription: String? {
        switch self {
        case .serviceError(error: let error):
            return NSLocalizedString("\(error.localizedDescription)", comment: "Service Error")
        case .invalidUrl:
            return NSLocalizedString(APP_ERROR, comment: "Invalid Error")
        case .missingData:
            return NSLocalizedString(APP_ERROR, comment: "Missing Error")
        case .unExpectedError:
            return NSLocalizedString(APP_ERROR, comment: "Unexpected Error")
        case .parseError:
            return NSLocalizedString(APP_ERROR, comment: "Parse Error")
        }
    }
}
