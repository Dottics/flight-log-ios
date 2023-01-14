//
//  SummaryComponents.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2023/01/14.
//

import SwiftUI

struct SummaryComponents: View {
    var body: some View {
        HStack {
            Column(width: 100) {
                Text("name")
            }
            Column(Text("name"), width: 100)
        }
    }
}

struct SummaryComponents_Previews: PreviewProvider {
    static var previews: some View {
        SummaryComponents()
    }
}
