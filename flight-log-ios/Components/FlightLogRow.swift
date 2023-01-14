//
//  FlightLogRow.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}

struct FlightLogRow: View {
    
    @ObservedObject var flightLog: FlightLog
    
    var pilot: String {
        if flightLog.pilotInCommand {
            return "ME"
        } else {
            let subStrings = flightLog.picName?.split(separator: " ")
            if subStrings!.count > 1 {
                return "\(subStrings![0][0])\(subStrings![1][0])"
            }
            return ""
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(pilot)
                    .bold()
                if flightLog.pic > 0 {
                    Text("\(NSString(format: "PIC %.1f", flightLog.pic))")
                } else {
                    Text("\(NSString(format: "CP %.1f", flightLog.copilot))")
                }
            }
            .frame(width: 80, height: 80)
            .background(
                flightLog.pic > 0
                ? .linearGradient(Gradient(colors: [.green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                : .linearGradient(Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            
            VStack(alignment: .leading) {
                Text(flightLog.unwrappedDetails)
                Text(flightLog.aircraftType?.unwrappedName ?? "")
                Text(flightLog.unwrappedDayType)
                Text(flightLog.unwrappedEngineType)
                Spacer()
            }
            .font(.footnote)
            .padding(4)
            
            Spacer()
            
            VStack {
                Text(flightLog.unwrappedDate)
                    .font(.footnote)
                Spacer()
            }
            .padding(4)
        }
        .frame(height: 80)
    }
}

struct FlightLogRow_Previews: PreviewProvider {
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
        flightLog.fstd = false
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
        
        let flightLog1 = FlightLog(context: viewContext)
        flightLog1.id = 2
        flightLog1.uuid = UUID()
        flightLog1.copilot = 0
        flightLog1.date = Date(timeInterval: -1000, since: .now)
        flightLog1.dayLandings = 1
        flightLog1.dayType = "day"
        flightLog1.details = "HKG - CPT"
        flightLog1.dual = 1
        flightLog1.fstd = false
        flightLog1.engineType = "single"
        flightLog1.instrumentActual = "A"
        flightLog1.instrumentNavAids = "Compass"
        flightLog1.instrumentPlace = ""
        flightLog1.nightLandings = 0
        flightLog1.pic = 1
        flightLog1.picus = 1
        flightLog1.picName = "SELF"
        flightLog1.pilotInCommand = true
        flightLog1.registration = "ABCXYZ"
        flightLog1.remarks = "Good stuff"
        flightLog1.aircraftType = aircraftType
        
        return List {
            FlightLogRow(flightLog: flightLog)
            FlightLogRow(flightLog: flightLog1)
        }
        .previewLayout(.fixed(width: 400, height: 300))
    }
}
