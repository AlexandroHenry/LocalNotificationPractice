//
//  LocalNotificationPracticeApp.swift
//  LocalNotificationPractice
//
//  Created by Seungchul Ha on 2023/02/09.
//

import SwiftUI

@main
struct LocalNotificationPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
