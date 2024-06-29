//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 27/06/2024.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navStack) {
                ContentView()
            }.environmentObject(router)
            
        }
    }
}
