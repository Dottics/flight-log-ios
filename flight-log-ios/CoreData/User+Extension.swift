//
//  User+Extension.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/30.
//

import Foundation

extension User {
    var unwrappedFirstName: String { firstName ?? "" }
    var unwrappedLastName: String { lastName ?? "" }
    var unwrappedLicenseNumber: String { licenseNumber ?? "" }
    var unwrappedEmail: String { email ?? "" }
}
