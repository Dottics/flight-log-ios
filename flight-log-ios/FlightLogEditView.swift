//
//  EditFlightLogView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

struct FlightLogEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var aircraftTypes: FetchedResults<AircraftType>
    
    @FocusState private var focusedField: Bool
    
    var flightLog: FlightLog?
    
    @State private var details: String = ""
    @State private var date: Date = .now
    @State private var aircraftTypeUUIDSelection: String? = nil
    
    @State private var flightSimulatorTrainingDeviceBool: Bool = false
    @State private var engineTypeBool: Bool = true
    @State private var dayTypeBool: Bool = true
    
    @State private var pilotInCommandBool: Bool = true
    @State private var pilotInCommand: String = ""
    @State private var dual: String = ""
    @State private var pic: String = ""
    @State private var picus: String = ""
    @State private var fstd: String = ""
    @State private var copilot: String = ""
    @State private var registration: String = ""
    
    @State private var instructorFSTD: String = ""
    @State private var instructorME: String = ""
    @State private var instructorSE: String = ""
    
    @State private var instrumentNavAids: String = ""
    @State private var instrumentPlace: String = ""
    @State private var instrumentActual: String = ""
    @State private var instrumentFSTD: String = ""
    
    @State private var remarks: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Flight")) {
                        DatePicker("Date", selection: $date)
                        TextField("Details", text: $details)
                        TextField("Registration", text: $registration)
                        Picker("Aircraft Type", selection: $aircraftTypeUUIDSelection) {
                            Text("Select")
                            ForEach(aircraftTypes) { aircraftType in
                                Text(aircraftType.unwrappedName).tag(aircraftType.uuid?.uuidString)
                            }
                        }
                    }
                    Section(header: Text("Toggles")) {
                        Toggle(isOn: $flightSimulatorTrainingDeviceBool) {
                            Text("FSTD")
                        }
                        Toggle(isOn: $engineTypeBool) {
                            Text("Multi Engine")
                        }
                        Toggle(isOn: $dayTypeBool) {
                            Text("Day flight")
                        }
                        Toggle(isOn: $pilotInCommandBool) {
                            Text("Pilot in Command")
                        }
                    }
                    Section(header: Text("Instrument")) {
                        TextField("Nav Aids", text: $instrumentNavAids)
                        TextField("Place", text: $instrumentPlace)
                        TextField("Actual", text: $instrumentActual)
                        TextField("FSTD", text: $instrumentFSTD)
                    }
                    Section(header: Text("Instructor")) {
                        TextField("FSTD", text: $instructorFSTD)
                        TextField("SE", text: $instructorSE)
                        TextField("ME", text: $instructorME)
                    }
                    Section(header: Text("PIC")) {
                        if pilotInCommandBool {
                            TextField("PIC", text: $pic)
                                .keyboardType(.numberPad)
                            TextField("PICUS", text: $picus)
                                .keyboardType(.numberPad)
                            TextField("FSTD", text: $fstd)
                                .keyboardType(.numberPad)
                        } else {
                            TextField("Pilot in Command", text: $pilotInCommand)
                            TextField("Copilot", text: $copilot)
                                .keyboardType(.numberPad)
                        }
                    }
                    Section(header: Text("Remarks")) {
                        TextField("Remarks", text: $remarks)
                    }
                }
            }
            .navigationTitle(flightLog == nil ? "New Flight Log" : "Edit Flight Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        save()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
            .onAppear {
                if aircraftTypes.count ==  0 {
                    print("load aircraft types")
                    defaultAircraftTypes(moc: moc)
                }
                if flightLog != nil {
                    details = flightLog!.unwrappedDetails
                    pic = flightLog!.unwrappedPIC
                    picus = flightLog!.unwrappedPICUS
                    pilotInCommandBool = flightLog!.pilotInCommand == "SELF"
                    engineTypeBool = flightLog!.engineType == "multi"
                    dayTypeBool = flightLog!.dayType == "day"
                    aircraftTypeUUIDSelection = flightLog!.aircraftType?.uuid?.uuidString
                }
            }
        }
    }
    
    func save() {
        let airct = aircraftTypes.first { at in
            at.uuid?.uuidString == aircraftTypeUUIDSelection
        }
        if flightLog == nil {
            let newFlightLog = FlightLog(context: moc)
            newFlightLog.id = 1
            newFlightLog.uuid = UUID()
            newFlightLog.details = details
            newFlightLog.registration = registration
            newFlightLog.date = date
            newFlightLog.dual = Float(dual) ?? 0
            newFlightLog.pic = Float(pic) ?? 0
            newFlightLog.picus = Float(picus) ?? 0
            newFlightLog.pilotInCommand = pilotInCommandBool ? "SELF" : pilotInCommand
            newFlightLog.copilot = Float(copilot) ?? 0
            newFlightLog.dayType = dayTypeBool ? "day" : "night"
            newFlightLog.engineType = engineTypeBool ? "multi" : "single"
            newFlightLog.aircraftType = airct
//            let airct = aircraftTypes.first { at in
//                at.uuid?.uuidString == aircraftTypeUUIDSelection
//            }
            newFlightLog.remarks = remarks
        } else {
            flightLog!.details = details
            flightLog!.dual = Float(dual) ?? 0
            flightLog!.pic = Float(pic) ?? 0
            flightLog!.picus = Float(picus) ?? 0
            flightLog!.fstd = Float(fstd) ?? 0
            flightLog!.pilotInCommand = pilotInCommandBool ? "SELF" : pilotInCommand
            flightLog!.aircraftType = airct
        }
        
        do {
            if moc.hasChanges {
                print("save")
                try moc.save()
            }
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct EditFlightLogView_Previews: PreviewProvider {
    static var previews: some View {
        FlightLogEditView(flightLog: nil)
            .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
