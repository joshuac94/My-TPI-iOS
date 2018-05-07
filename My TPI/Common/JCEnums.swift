//
//  JCApplianceEnums.swift
//  My TPI
//
//  Created by Joshua Colley on 09/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

enum JCChecklistResponse: String {
    case satisfactory = "Satisfactory"
    case unsatisfactory = "Unsatisfactory"
    case notApplicable = "Not Applicable"
    case notAvailable = "Not Available"
    case empty = ""
}

enum JCBasicResponse: String {
    case yes = "Yes"
    case no = "No"
    case notApplicable = "Not Applicable"
    case notAvailable = "Not Available"
    case empty = ""
}

enum JCInspectionOutcome: String {
    case incomplete = "Incomplete"
    case satisfactory = "Satisfactory"
    case unsatisfactory = "Unsatisfactory"
}
