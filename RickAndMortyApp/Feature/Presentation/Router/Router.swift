//
//  Router.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 29/06/2024.
//

import SwiftUI

protocol RouterDelegate {
    associatedtype Route = Path
    func pushView(_ newView: Route)
    func popRoot()
    func pop()
    func popUntil(_ tragetRoute: Route)
}

extension Router {
    enum Paths: Equatable, CaseIterable {
        static var allCases: [Router.Paths] = [.homePage]
        case homePage
        case custom(view: AnyView)
    }
    
    enum Routes {
        static let routes: [Paths: AnyView] = [
            .homePage: AnyView(HomePage())
        ]
    }
    
    static func getRoute(for path: Paths) -> AnyView {
        switch path {
            case .homePage:
                return AnyView(HomePage())
            case .custom(let view):
                return view
        }
    }
}

class Router: ObservableObject, RouterDelegate {
    @Environment(\.presentationMode) var presentationMode
    @Published var navStack: [Paths] = []
    
    func pushView(_ newView: Paths) {
        navStack.append(newView)
    }
    
    func popRoot() {
        navStack.removeAll()
    }
    
    func pop() {
        if !navStack.isEmpty {
            navStack.removeLast()
        }
    }
    
    func popUntil(_ tragetRoute: Paths) {
        if !navStack.isEmpty {
            navStack.removeLast()
        }
    }
    
}

extension View {
    func pushPath() -> some View {
        self.navigationDestination(for: Router.Paths.self) { path in
            Router.getRoute(for: path)
        }
    }
}

extension Router.Paths: Hashable {
    static func == (lhs: Router.Paths, rhs: Router.Paths) -> Bool {
            switch (lhs, rhs) {
                case (.homePage, .homePage):
                    return true
            case (.custom, .custom):
                return true
            default:
                return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .homePage:
            hasher.combine("homePage")
        case .custom(_):
            hasher.combine("custom")
        }
    }
}
