//
//  OrganizerApp.swift
//  Organizer
//
//  Created by Student on 07/02/2021.
//

import SwiftUI

@main
struct OrganizerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
