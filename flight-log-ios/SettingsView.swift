//
//  SettingsView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        ProfileSection()
                    }
                }
                Section(header: Text("Settings")) {
                    // Text("hi")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}

struct ProfileSection: View {
    @FetchRequest(sortDescriptors: [])
    private var users: FetchedResults<User>
    
    var user: User {
        users[0]
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(.blue)
                .opacity(0.7)
                .frame(width: 50, height: 50)
            Text("\(user.unwrappedFirstName) \(user.unwrappedLastName)")
        }
    }
}
