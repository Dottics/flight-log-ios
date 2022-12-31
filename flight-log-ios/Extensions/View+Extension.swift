//
//  View+Extension.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
