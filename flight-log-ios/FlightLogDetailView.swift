//
//  FlightLogDetailView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/26.
//

import SwiftUI

struct FlightLogDetailView: View {
    @StateObject var flightLog: FlightLog
    
    @State private var showEditFlightLog: Bool = false
    
    var body: some View {
        VStack {
            Text(flightLog.unwrappedDetails)
            Text(flightLog.unwrappedDate)
            Spacer()
        }
        .navigationTitle("Flight Log Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showEditFlightLog.toggle()
                }
            }
        }
        .sheet(isPresented: $showEditFlightLog) {
            FlightLogEditView(flightLog: flightLog)
        }
    }
}

struct FlightLogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceContainer.preview.viewContext
        
        let aircraftType = AircraftType(context: viewContext)
        aircraftType.id = 1
        aircraftType.uuid = UUID()
        aircraftType.name = "A380"
        aircraftType.typeDescription = "Airbus 380"
        
        let flightLog = FlightLog(context: viewContext)
        flightLog.id = 1
        flightLog.uuid = UUID()
        flightLog.copilot = 1
        flightLog.date = Date(timeInterval: -1000, since: .now)
        flightLog.dayLandings = 1
        flightLog.dayType = "day"
        flightLog.details = "HKG - CPT"
        flightLog.dual = 1
        flightLog.engineType = "single"
        flightLog.fstd = 1
        flightLog.instructorFSTD = 1
        flightLog.instructorME = 1
        flightLog.instructorSE = 1
        flightLog.instrumentActual = "A"
        flightLog.instrumentFSTD = 1
        flightLog.instrumentNavAids = "Compass"
        flightLog.instrumentPlace = ""
        flightLog.nightLandings = 0
        flightLog.pic = 0
        flightLog.picus = 1
        flightLog.pilotInCommand = "James Bond"
        flightLog.registration = "ABCXYZ"
        flightLog.remarks = "Good stuff"
        flightLog.aircraftType = aircraftType
        
        return FlightLogDetailView(flightLog: flightLog)
            .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
