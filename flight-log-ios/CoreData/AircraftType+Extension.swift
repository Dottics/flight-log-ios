//
//  AircraftType+Extension.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import Foundation
import CoreData

extension AircraftType {
    var unwrappedName: String { name ?? "" }
}

func defaultAircraftTypes(moc: NSManagedObjectContext) {
    let aircraftTypes = [
        ["name": "A310", "description": "Airbus 310"],
        ["name": "A320", "description": "Airbus 320"],
        ["name": "A380", "description": "Airbus 380"]
    ]
    
    var index = 0
    for at in aircraftTypes {
        index += 1
        let aircraftType = AircraftType(context: moc)
        aircraftType.id = Int16(index)
        aircraftType.uuid = UUID()
        aircraftType.name = at["name"]
        aircraftType.typeDescription = at["description"]
    }
    
    do {
        try moc.save()
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
