//
//  FlightLogView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

struct FlightLogListView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    private var flightLogs: FetchedResults<FlightLog>
    
    var body: some View {
        VStack {
            ForEach(flightLogs, id: \.uuid) { flightLog in
                NavigationLink {
                    FlightLogDetailView(flightLog: flightLog)
                } label: {
                    HStack {
                        FlightLogRow(flightLog: flightLog)
                        Image(systemName: "chevron.right")
                    }
                    .padding(.bottom, 12)
                }
                .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Flight Log")
    }
    
}

struct FlightLogView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationStack {
            FlightLogListView()
        }.environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
