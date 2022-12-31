//
//  PersistenceContainer.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import Foundation
//
//  ModelsContainer.swift
//  S3LiDAR
//
//  Created by Johannes Scribante on 2022/12/21.
//

import Foundation
import CoreData

class PersistenceContainer {
    let persistentContainer: NSPersistentContainer
    
    /// shared is to create a singleton
    static let shared = PersistenceContainer()
    
    /// viewContext is just a convenient way of accessing the viewContext
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /// preview is for previews in SwiftUI while developing, the context is created "in memory"
    static var preview: PersistenceContainer {
        let result = PersistenceContainer(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        
        let user = User(context: viewContext)
        user.id = 1
        user.uuid = UUID()
        user.firstName = "Oliver"
        user.lastName = "Wright"
        user.email = "oliver.wright@wingit.co"
        user.licenseNumber = "XYZ1001ABC9876"
        
        let aircraftType1 = AircraftType(context: viewContext)
        aircraftType1.id = 1
        aircraftType1.uuid = UUID()
        aircraftType1.name = "A380"
        aircraftType1.typeDescription = "Airbus 380"
        
        let flightLog1 = FlightLog(context: viewContext)
        flightLog1.id = 1
        flightLog1.uuid = UUID()
        flightLog1.copilot = 1
        flightLog1.date = Date(timeInterval: -1000, since: .now)
        flightLog1.dayLandings = 1
        flightLog1.dayType = "day"
        flightLog1.details = "HKG - CPT"
        flightLog1.dual = 1
        flightLog1.engineType = "single"
        flightLog1.fstd = 1
        flightLog1.instructorFSTD = 1
        flightLog1.instructorME = 1
        flightLog1.instructorSE = 1
        flightLog1.instrumentActual = "A"
        flightLog1.instrumentFSTD = 1
        flightLog1.instrumentNavAids = "Compass"
        flightLog1.instrumentPlace = ""
        flightLog1.nightLandings = 0
        flightLog1.pic = 1
        flightLog1.picus = 1
        flightLog1.pilotInCommand = "SELF"
        flightLog1.registration = "ABCXYZ"
        flightLog1.remarks = "Good stuff"
        flightLog1.aircraftType = aircraftType1
        
        let flightLog2 = FlightLog(context: viewContext)
        flightLog2.id = 2
        flightLog2.uuid = UUID()
        flightLog2.copilot = 1
        flightLog2.date = Date(timeInterval: -10000, since: .now)
        flightLog2.dayLandings = 1
        flightLog2.dayType = "day"
        flightLog2.details = "HKG - JNB"
        flightLog2.dual = 1
        flightLog2.engineType = "single"
        flightLog2.fstd = 1
        flightLog2.instructorFSTD = 1
        flightLog2.instructorME = 1
        flightLog2.instructorSE = 1
        flightLog2.instrumentActual = "A"
        flightLog2.instrumentFSTD = 1
        flightLog2.instrumentNavAids = "Compass"
        flightLog2.instrumentPlace = ""
        flightLog2.nightLandings = 0
        flightLog2.pic = 0
        flightLog2.picus = 1
        flightLog2.pilotInCommand = "Jimmy Doolittle"
        flightLog2.registration = "ABCXYZ"
        flightLog2.remarks = "Good stuff"
        flightLog2.aircraftType = aircraftType1
        
        let flightLog3 = FlightLog(context: viewContext)
        flightLog3.id = 3
        flightLog3.uuid = UUID()
        flightLog3.copilot = 1
        flightLog3.date = Date(timeInterval: -100000, since: .now)
        flightLog3.dayLandings = 1
        flightLog3.dayType = "day"
        flightLog3.details = "HKG - JNB"
        flightLog3.dual = 1
        flightLog3.engineType = "single"
        flightLog3.fstd = 1
        flightLog3.instructorFSTD = 1
        flightLog3.instructorME = 1
        flightLog3.instructorSE = 1
        flightLog3.instrumentActual = "A"
        flightLog3.instrumentFSTD = 1
        flightLog3.instrumentNavAids = "Compass"
        flightLog3.instrumentPlace = ""
        flightLog3.nightLandings = 0
        flightLog3.pic = 0
        flightLog3.picus = 1
        flightLog3.pilotInCommand = "Jimmy Doolittle"
        flightLog3.registration = "ABCXYZ"
        flightLog3.remarks = "Good stuff"
        flightLog3.aircraftType = aircraftType1
        
        result.saveContext()
        
        return result
    }
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Models")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: Unable to load core data: Models: \(error.localizedDescription)")
            }
        }
    }
    
    /// saveContext is convenient way of saving data only when data has changes
    func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unable to save data: \(error.localizedDescription)")
            }
        }
    }
}
