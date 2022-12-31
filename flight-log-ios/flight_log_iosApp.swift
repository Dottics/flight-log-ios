//
//  flight_log_iosApp.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

@main
struct flight_log_iosApp: App {
    let persistenceContainer = PersistenceContainer.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.viewContext)
        }
    }
}
