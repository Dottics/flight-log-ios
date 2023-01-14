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
        VStack(alignment: .leading) {
            HStack {
                Text(flightLog.unwrappedDate)
                    .font(.title2)
                Spacer()
                if flightLog.fstd {
                    VStack {
                        Image(systemName: "compass.drawing")
                            .frame(width: 30, height: 30)
                            .background(.red.opacity(0.2))
                        .cornerRadius(8)
                        Text("FSTD")
                            .font(.caption)
                    }
                }
                if flightLog.instructor {
                    VStack {
                        Image(systemName: "graduationcap")
                            .frame(width: 30, height: 30)
                            .background(.orange.opacity(0.2))
                            .cornerRadius(8)
                        Text("INST")
                            .font(.caption)
                    }
                }
            }
            Text("PIC \(flightLog.unwrappedPICName)")
            HStack {
                Image(systemName: "airplane")
                Text(flightLog.aircraftType?.unwrappedName ?? "")
                Text(flightLog.unwrappedRegistration)
                Image(systemName: "engine.combustion.fill")
                Text(flightLog.unwrappedEngineType)
            }
            Text("Details")
                .bold()
                .padding(.vertical, 2)
            Text(flightLog.unwrappedDetails)
            Text("Remarks")
                .bold()
                .padding(.vertical, 2)
            Text(flightLog.unwrappedRemarks)
            Spacer()
        }
        .padding(.horizontal)
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
        flightLog.fstd = true
        flightLog.instructor = true
        flightLog.instrumentActual = "A"
        flightLog.instrumentNavAids = "Compass"
        flightLog.instrumentPlace = ""
        flightLog.nightLandings = 0
        flightLog.pic = 0
        flightLog.picus = 1
        flightLog.pilotInCommand = false
        flightLog.picName = "James Bond"
        flightLog.registration = "ABCXYZ"
        flightLog.remarks = "Good stuff"
        flightLog.aircraftType = aircraftType
        
        return NavigationStack {
            FlightLogDetailView(flightLog: flightLog)
        }
        .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
