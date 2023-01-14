//
//  FlightLog+Extension.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import Foundation

extension FlightLog {
    var unwrappedDate: String {
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date!)
        }
        return ""
    }
    var unwrappedPIC: String {
        String(format: "%.1f", pic)
    }
    var unwrappedPICUS: String {
        String(format: "%.1f", picus)
    }
    var unwrappedFSTD: String {
//        String(format: "%.1f", fstd)
        return "0"
    }
    var unwrappedCopilot: String {
        String(format: "%.1f", copilot)
    }
    var unwrappedDayType: String { dayType ?? "" }
    var unwrappedEngineType: String { engineType ?? "" }
    
    var unwrappedPICName: String { picName ?? "" }
    var unwrappedDetails: String { details ?? "" }
    var unwrappedRemarks: String { remarks ?? "" }
    var unwrappedRegistration: String { registration ?? "" }
}
