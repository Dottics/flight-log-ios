//
//  ContentView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(sortDescriptors: [])
    private var users: FetchedResults<User>
    
    @State private var selection: Int = 1
    @State private var showNewFlightLog: Bool = false
    @State private var showSettings: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                DashboardView()
                    .navigationTitle("hi")
                    .tabItem { Image(systemName: "chart.pie.fill") }.tag(1)
                FlightLogListView()
                    .tabItem { Image(systemName: "list.dash") }.tag(2)
            }
            //.overlay(Rectangle().stroke(style: StrokeStyle(lineWidth: 1)))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "person.crop.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showNewFlightLog = true }) {
                        Image(systemName: "pencil.circle")
                    }
                }
            }
            .navigationTitle(selection == 1 ? "Dashboard" : "Flight Logs")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if users.count == 0 {
                // add the default user
                let user = User(context: moc)
                user.id = 1
                do {
                    try moc.save()
                } catch {
                    fatalError("Error: \(error.localizedDescription)")
                }
            }
        }
        .sheet(isPresented: $showNewFlightLog) {
            FlightLogEditView(flightLog: nil)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
