//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Joe Harrison on 2024-07-25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}