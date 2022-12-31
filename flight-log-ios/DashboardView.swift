//
//  DashboardView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import SwiftUI

//struct AircraftStats {
//    var dual: Float
//    var pic: Float
//    var picus: Float
//    var copilot: Float
//}

class StatsEntry: ObservableObject {
    var instrumentActual: Float
    // flight simulation training device
    var instrumentFSTD: Float
    // single-engine
    var instructorSE: Float
    // multi-engine
    var instructorME: Float
    var instructorFSTD: Float
    var fstd: Float
    var dayLandings: Float
    var nightLandings: Float
    
    var seDayStats: AircraftStats
    var seNightStats: AircraftStats
    
    var meDayStats: AircraftStats
    var meNightStats: AircraftStats
    
    struct AircraftStats {
        var dual: Float
        var pic: Float
        var picus: Float
        var copilot: Float
        
        init() {
            dual = 0
            pic = 0
            picus = 0
            copilot = 0
        }
    }
    
    init() {
        instrumentActual = 0
        instrumentFSTD = 0
        instructorSE = 0
        instructorME = 0
        instructorFSTD = 0
        fstd = 0
        dayLandings = 0
        nightLandings = 0
        seDayStats = AircraftStats()
        seNightStats = AircraftStats()
        meDayStats = AircraftStats()
        meNightStats = AircraftStats()
    }
}

/// DashboardView is to show all the overall stats of the user.
struct DashboardView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    private var flightLogs: FetchedResults<FlightLog>
    
    @State private var summaryTotals: StatsEntry = StatsEntry()
    
    var totalPIC: Float {
        var total: Float  = 0
        for flightLog in flightLogs {
            total += flightLog.pic
        }
        return total
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Totals")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 10) {
                    Text("Instrument")
                    HStack(alignment: .bottom) {
                        Text("\(String(format: "%.1f", summaryTotals.instrumentFSTD))")
                        Text("FSTD")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                }
                HStack(spacing: 10) {
                    Text("Instructor")
                    HStack(alignment: .bottom) {
                        Text("\(String(format: "%.1f", summaryTotals.instructorFSTD))")
                        Text("FSTD")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                    HStack(alignment: .bottom) {
                        Text("\(String(format: "%.1f", summaryTotals.instructorSE))")
                        Text("SE")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                    HStack(alignment: .bottom) {
                        Text("\(String(format: "%.1f", summaryTotals.instructorME))")
                        Text("SE")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                }
                Text("Total flights: \(flightLogs.count)")
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            
            VStack(alignment: .leading) {
                Text("Single Engine")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("Dual")
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seDayStats.dual))
                        Text("Day")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seNightStats.dual))
                        Text("Night")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                }
                HStack {
                    Text("PIC")
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seDayStats.pic))
                        Text("Day")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seNightStats.pic))
                        Text("Night")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                }
                HStack {
                    Text("PICUS")
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seDayStats.picus))
                        Text("Day")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seNightStats.picus))
                        Text("Night")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                }
                HStack {
                    Text("copilot")
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seDayStats.copilot))
                        Text("Day")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.1f", summaryTotals.seNightStats.copilot))
                        Text("Night")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.leading, -5)
                    }
                }
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            
            Spacer()
        }
        .padding()
//        .onAppear(perform: lastStats)
    }
    
    
    /// lastStats calculates the latest stats for the pilot as a rolled up summary of
    /// the last few periods, such as the last 7 days, 30 days, etc.
    func lastStats() -> StatsEntry {
        var summaryTotals = StatsEntry()
        
        for log in flightLogs {
//            summaryTotals.instrumentActual += log.instrumentActual
            summaryTotals.instrumentFSTD += log.instrumentFSTD
            summaryTotals.instructorFSTD += log.instructorFSTD
            summaryTotals.instructorSE += log.instructorSE
            summaryTotals.instructorME += log.instructorME
            
            if log.engineType == "single" && log.dayType == "day" {
                summaryTotals.seDayStats.dual += log.dual
                summaryTotals.seDayStats.pic += log.pic
                summaryTotals.seDayStats.picus += log.picus
                summaryTotals.seDayStats.copilot += log.copilot
            }
            
            if log.engineType == "single" && log.dayType == "night" {
                summaryTotals.seNightStats.dual += log.dual
                summaryTotals.seNightStats.pic += log.pic
                summaryTotals.seNightStats.picus += log.picus
                summaryTotals.seNightStats.copilot += log.copilot
            }
        }
        
        // self.summaryTotals = summaryTotals
        return summaryTotals
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
            DashboardView()
                .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
