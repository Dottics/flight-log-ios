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
    
//    @StateObject private var summaryTotals: StatsEntry = StatsEntry()
    
    var totalPIC: Float {
        var total: Float  = 0
        for flightLog in flightLogs {
            total += flightLog.pic
        }
        return total
    }
    
    var summaryTotals: StatsEntry {
        return lastStats()
    }
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Totals")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 10) {
                    Column(width: 100) {
                        Text("Instrument")
                    }
                    Column(width: 70) {
                        HStack(alignment: .bottom) {
                            Text("\(String(format: "%.1f", summaryTotals.instrumentFSTD))")
                            Text("FSTD")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.leading, -5)
                        }
                    }
                }
                HStack(spacing: 10) {
                    Column(width: 100) {
                        Text("Instructor")
                    }
                    Column(width: 70) {
                        HStack(alignment: .bottom) {
                            Text("\(String(format: "%.1f", summaryTotals.instructorFSTD))")
                            Text("FSTD")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.leading, -5)
                        }
                    }
                    Column(width: 60) {
                        HStack(alignment: .bottom) {
                            Text("\(String(format: "%.1f", summaryTotals.instructorSE))")
                            Text("SE")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.leading, -5)
                        }
                        
                    }
                    Column(width: 60) {
                        HStack(alignment: .bottom) {
                            Text("\(String(format: "%.1f", summaryTotals.instructorME))")
                            Text("ME")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.leading, -5)
                        }
                    }
                }
                HStack {
                    Column(width: 100) {
                        Text("Total flights")
                    }
                    Column(width: 70) {
                        Text("\(flightLogs.count)")
                    }
                }
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            
            VStack(alignment: .leading) {
                Text("Summary")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Column(width: 100) {Spacer()}
                    Column(width: 100, alignment: .center) {Text("Multi")}
                    Column(width: 100, alignment: .center) {Text("Single")}
                }
                HStack {
                    Column(width: 100) {Spacer()}
                    Column(width: 50, alignment: .center) {
                        Text("Day")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Column(width: 50, alignment: .center) {
                        Text("Night")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Column(width: 50, alignment: .center) {
                        Text("Day")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Column(width: 50, alignment: .center) {
                        Text("Night")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                HStack {
                    Column(width: 100) {
                        Text("Dual")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seDayStats.dual, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seNightStats.dual, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meDayStats.dual, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meNightStats.dual, caption: "")
                    }
                }
                HStack {
                    Column(width: 100) {
                        Text("PIC")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seDayStats.pic, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seNightStats.pic, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meDayStats.pic, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meNightStats.pic, caption: "")
                    }
                }
                HStack {
                    Column(width: 100) {
                        Text("PICUS")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seDayStats.picus, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seNightStats.picus, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meDayStats.picus, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meNightStats.picus, caption: "")
                    }
                }
                HStack {
                    Column(width: 100) {
                        Text("Copilot")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seDayStats.copilot, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.seNightStats.copilot, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meDayStats.copilot, caption: "")
                    }
                    Column(width: 50, alignment: .trailing) {
                        StatisticValue(value: summaryTotals.meNightStats.copilot, caption: "")
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
        .onAppear{
            
        }
    }
    
    
    /// lastStats calculates the latest stats for the pilot as a rolled up summary of
    /// the last few periods, such as the last 7 days, 30 days, etc.
    func lastStats() -> StatsEntry{
        let summaryTotals = StatsEntry()
        for log in flightLogs {
//            summaryTotals.instrumentFSTD += log.instrumentFSTD
//            summaryTotals.instructorFSTD += log.instructorFSTD
//            summaryTotals.instructorSE += log.instructorSE
//            summaryTotals.instructorME += log.instructorME
            
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
            
            if log.engineType == "multi" && log.dayType == "day" {
                summaryTotals.meDayStats.dual += log.dual
                summaryTotals.meDayStats.pic += log.pic
                summaryTotals.meDayStats.picus += log.picus
                summaryTotals.meDayStats.copilot += log.copilot
            }
            
            if log.engineType == "multi" && log.dayType == "night" {
                summaryTotals.meNightStats.dual += log.dual
                summaryTotals.meNightStats.pic += log.pic
                summaryTotals.meNightStats.picus += log.picus
                summaryTotals.meNightStats.copilot += log.copilot
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

struct StatisticValue: View {
    var value: Float
    var caption: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(String(format: "%.1f", value))
                .foregroundColor(value > 0 ? .primary : .secondary)
//            Text(caption)
//                .font(.caption2)
//                .foregroundColor(.secondary)
//                .padding(.leading, -5)
        }
    }
}
