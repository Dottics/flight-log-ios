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
        ScrollView {
            ForEach(flightLogs, id: \.uuid) { flightLog in
                NavigationLink {
                    FlightLogDetailView(flightLog: flightLog)
                } label: {
                    HStack {
                        FlightLogRow(flightLog: flightLog)
                            .padding(.leading, 8)
                            .padding(8)
                        Image(systemName: "chevron.right")
                            .padding(.trailing)
                    }
                }
                .foregroundColor(.primary)
            }
            Spacer()
        }
    }
    
}

struct FlightLogListView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationStack {
            FlightLogListView()
        }.environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
