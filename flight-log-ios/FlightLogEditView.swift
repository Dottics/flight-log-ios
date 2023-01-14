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
    
    @State private var engineTypeBool: Bool = true
    @State private var dayTypeBool: Bool = true
    @State private var instructor: Bool = false
    
    @State private var pilotInCommand: Bool = true
    @State private var dual: String = ""
    @State private var pic: String = ""
    @State private var picName: String = ""
    @State private var picus: String = ""
    @State private var fstd: Bool = false
    @State private var copilot: String = ""
    @State private var registration: String = ""
    
    @State private var instrumentNavAids: String = ""
    @State private var instrumentPlace: String = ""
    @State private var instrumentActual: String = ""
    
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
                        Toggle(isOn: $fstd) {
                            Text("FSTD")
                        }
                        Toggle(isOn: $engineTypeBool) {
                            HStack {
                                Text("Multi")
                                    .foregroundColor(engineTypeBool ? .primary : .secondary)
                                Text("Single")
                                    .foregroundColor(engineTypeBool ? .secondary : .primary)
                                Text("Engine")
                            }
                            
                        }
                        Toggle(isOn: $dayTypeBool) {
                            HStack {
                                Text("Day")
                                    .foregroundColor(dayTypeBool ? .primary : .secondary)
                                Text("Night")
                                    .foregroundColor(dayTypeBool ? .secondary : .primary)
                            }
                            
                        }
                        Toggle(isOn: $instructor) {
                            Text("Instructor")
                        }
                    }
                    Section(header: Text("Instrument")) {
                        TextField("Nav Aids", text: $instrumentNavAids)
                        TextField("Place", text: $instrumentPlace)
                        TextField("Actual", text: $instrumentActual)
                    }
                    Section(header: Text("PIC")) {

                        Toggle(isOn: $pilotInCommand) {
                            Text("Pilot in Command")
                        }
                        if pilotInCommand {
                            TextField("PIC", text: $pic)
                                .keyboardType(.decimalPad)
                            TextField("PICUS", text: $picus)
                                .keyboardType(.decimalPad)
                        } else {
                            TextField("Pilot in Command", text: $picName)
                            TextField("Copilot", text: $copilot)
                                .keyboardType(.decimalPad)
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
                    picName = flightLog!.picName ?? ""
                    pilotInCommand = flightLog!.pilotInCommand
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
            
            newFlightLog.pilotInCommand = pilotInCommand
            newFlightLog.picName = pilotInCommand ? "SELF" : picName
            newFlightLog.pic = Float(pic) ?? 0
            newFlightLog.picus = Float(picus) ?? 0
            newFlightLog.copilot = Float(copilot) ?? 0
            
            newFlightLog.dayType = dayTypeBool ? "day" : "night"
            newFlightLog.engineType = engineTypeBool ? "multi" : "single"
            newFlightLog.aircraftType = airct
            newFlightLog.remarks = remarks
        } else {
            flightLog!.details = details
            flightLog!.dual = Float(dual) ?? 0
            flightLog!.pic = Float(pic) ?? 0
            flightLog!.picus = Float(picus) ?? 0
            flightLog!.fstd = fstd
            flightLog!.picName = pilotInCommand ? "SELF" : picName
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
