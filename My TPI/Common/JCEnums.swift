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

enum JCBasicResponse: Int, CustomStringConvertible {
    case empty
    case yes
    case no
    case notApplicable
    case notAvailable
    case count
    
    var description: String {
        switch self {
        case .empty: return "Please Select"
        case .yes: return "Yes"
        case .no: return "No"
        case .notApplicable: return "Not Applicable"
        case .notAvailable: return "Not Available"
        default: return ""
        }
    }
}

enum JCInspectionOutcome: String {
    case incomplete = "Incomplete"
    case satisfactory = "Satisfactory"
    case unsatisfactory = "Unsatisfactory"
}

enum JCInspectionType: Int, CustomStringConvertible {
    case empty
    case visual
    case exam
    case test
    case count
    
    var description: String {
        switch self {
        case .empty: return "Please Select"
        case .visual: return "Visual Examination"
        case .exam: return "Thorough Examination"
        case .test: return "Test & Thorough Examination"
        default: return ""
        }
    }
}

enum JCReason: Int, CustomStringConvertible {
    case empty
    case sixMonth
    case twelveMonth
    case count
    
    var description: String {
        switch self {
        case .empty: return "Please Select"
        case .sixMonth: return "6 Month Period"
        case .twelveMonth: return "12 Month Period"
        default: return ""
        }
    }
}
