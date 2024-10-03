//
//  GoWhereApp.swift
//  GoWhere
//
//  Created by Hang Vu on 25/9/2024.
//

import SwiftUI

@main
struct GoWhereApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LaunchScreenView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
