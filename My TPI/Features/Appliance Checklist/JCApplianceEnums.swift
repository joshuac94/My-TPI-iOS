//
//  JCApplianceEnums.swift
//  My TPI
//
//  Created by Joshua Colley on 01/05/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

enum JCApplianceType: Int, CustomStringConvertible {
    case mewp
    case empty
    
    var description: String {
        switch self {
        case .mewp:
            return "Mobile Elevating Work Platform"
        default:
            return ""
        }
    }
}

enum JCApplianceInspectionType: Int, CustomStringConvertible {
    case visual
    case empty
    
    var description: String {
        switch self {
        case .visual:
            return "Visual Examination"
        default:
            return ""
        }
    }
}

enum JCApplianceSections: Int, CustomStringConvertible {
    case inspectionDetails
    case documentation
    case machineDetails
    case generalCondition
    case mechanicalStructure
    case wireRopeSystem
    case electricalSystem
    case safetyDevices
    case functionality
    case testing
    case summary
    case count
    
    var description: String {
        switch self {
        case .inspectionDetails: return "Inspection Details"
        case .documentation: return "Documentation"
        case .machineDetails: return "Equipment Details"
        case .generalCondition: return "General Condition"
        case .mechanicalStructure: return "Mechanical Systems"
        case .wireRopeSystem: return "Wire Rope Systems"
        case .electricalSystem: return "Electrical Systems"
        case .safetyDevices: return "Safety Devices & Operational Aids"
        case .functionality: return "Functionality"
        case .testing: return "Testing"
        case .summary: return "Inspection Summary"
        default:
            return ""
        }
    }
}

// MARK: - Details Rows
enum JCInspectionDetailsRows: Int, CustomStringConvertible {
    case inspectionType
    case clientName
    case clientAddress
    case dateOfInspection
    case inspectionNumber
    case timesheetRef
    case inspectorsName
    case reasonForInspection
    case isFirstTest
    case isInstalledCorrectly
    case location
    case standards
    case count
    
    var description: String {
        switch self {
        case .inspectionType: return "Inspection Type"
        case .clientName: return "Client's Name"
        case .clientAddress: return "Client's Address"
        case .dateOfInspection: return "Date of Inspection"
        case .inspectionNumber: return "Inspection Number"
        case .timesheetRef: return "Timesheet Reference"
        case .inspectorsName: return "Inspector's Name"
        case .reasonForInspection: return "Reason for Inspection"
        case .isFirstTest: return "First Examination/Test after Installation or Assembly?"
        case .isInstalledCorrectly: return "Was the Equipment Installed Correctly?"
        case .location: return "Location of Inspection"
        case .standards: return "Referenced Standard(s)"
        default: return ""
        }
    }
}

// MARK: - Documentation Rows
enum JCDocumentationRows: Int, CustomStringConvertible {
    case previousExamCert
    case previousTestCert
    case ndtReportReference
    case mainRopeCertReference
    case auxRopeCertReference
    case trolleyRopeCertReference
    case luffingRopeCertReference
    case electricalCertReference
    case compactTestCertReference
    case maintenanceRecordsReference
    case count
    
    var description: String {
        switch self {
        case .previousExamCert: return "Previous Exam Certificate"
        case .previousTestCert: return "Previous Test Certificate"
        case .ndtReportReference: return "NDT Report"
        case .mainRopeCertReference: return "Primary Hoist Rope Certificate"
        case .auxRopeCertReference: return "Auxiliary Hoist Rope Certificate"
        case .trolleyRopeCertReference: return "Trolley Hoist Rope Certificate"
        case .luffingRopeCertReference: return "Luffing Hoist Rope Certificate"
        case .electricalCertReference: return "Electrical Testing Report"
        case .compactTestCertReference: return "Compact Test Report"
        case .maintenanceRecordsReference: return "Maintenance Records"
        default: return ""
        }
    }
}

// MARK: - Machine Rows
enum JCMachineDetailsRows: Int, CustomStringConvertible {
    case equipmentType
    case fleetNumber
    case serialNumber
    case make
    case model
    case capacity
    case workingHours
    case mileageReading
    case registration
    case equipmentDescription
    case counterWeight
    case counterBallast
    case count
    
    var description: String {
        switch self {
        case .equipmentType: return "Equipment Type"
        case .fleetNumber: return "Fleet No."
        case .serialNumber: return "Serial No."
        case .make: return "Make"
        case .model: return "Model"
        case .capacity: return "Capacity"
        case .workingHours: return "Working Hours"
        case .mileageReading: return "Mileage Reading"
        case .registration: return "Registration No."
        case .equipmentDescription: return "Equipment Description"
        case .counterWeight: return "Counter Weight"
        case .counterBallast: return "Ballast Weight"
        default: return ""
        }
    }
}

// MARK: - General Rows
enum JCGeneralConditionRows: Int, CustomStringConvertible {
    case manual
    case dataPlate
    case decals
    case fireExtinguisher
    case functionMarkings
    case covers
    case handRails
    case walkways
    case cabinCondition
    case loadCharts
    case lights
    case windowsMirrors
    case visualCondition
    case count
    
    var description: String {
        switch self {
        case .manual: return "Operation/Manufacturer's Manual"
        case .dataPlate: return "Data Plate"
        case .decals: return "Safety/Warning Decals"
        case .fireExtinguisher: return "Fire Extinguisher(s)"
        case .functionMarkings: return "Function ID Markings"
        case .covers: return "Guards & Covers"
        case .handRails: return "Hand Rails / Steps & Ladders"
        case .walkways: return "Walkways / Platforms"
        case .cabinCondition: return "Cabin Condition"
        case .loadCharts: return "Load Chart(s)"
        case .lights: return "Operational & Warning Lights"
        case .windowsMirrors: return "Windows & Mirrors"
        case .visualCondition: return "Overall Visual Condition"
        default: return ""
        }
    }
}

// MARK: - Mechanical Rows
enum JCMechanicalStructureRows: Int, CustomStringConvertible {
    case chassis
    case slewing
    case counterWeight
    case ballastWeight
    case outriggers
    case engineCondition
    case sparkArrestor
    case airIntake
    case hydraulics
    case fluidLevels
    case welding
    case bolts
    case brakingSystem
    case tyresWheels
    case tracks
    case superstructure
    case cylinders
    case chains
    case hookBlocks
    case forks
    case motors
    case count
    
    var description: String {
        switch self {
        case .chassis: return "Chassis Condition"
        case .slewing: return "Slewing Mechanism"
        case .counterWeight: return "Counter Weights"
        case .ballastWeight: return "Central Ballast"
        case .outriggers: return "Outriggers & Stabilizers"
        case .engineCondition: return "Engine Condition"
        case .sparkArrestor: return "Spark Arrestor"
        case .airIntake: return "Air Intake Valve / Chalwyn Valve"
        case .hydraulics: return "Hydraulics System(s)"
        case .fluidLevels: return "Fluid Levels"
        case .welding: return "Welding Condition"
        case .bolts: return "Bolts & Connections"
        case .brakingSystem: return "Braking System(s)"
        case .tyresWheels: return "Tyres & Wheels"
        case .tracks: return "Tracks"
        case .superstructure: return "Superstructure Condition"
        case .cylinders: return "Lifting Cylinders"
        case .chains: return "Lifting Chains"
        case .hookBlocks: return "Condition of Hook Block(s)"
        case .forks: return "Condition of Forks"
        case .motors: return "Condition of Motor(s)"
        default: return ""
        }
    }
}

// MARK: - Wire Rope Rows
enum JCWireRopeSystemRows: Int, CustomStringConvertible {
    case drums
    case termination
    case lubrication
    case mainRope
    case mainLinePull
    case auxRope
    case auxLinePull
    case trolleyRope
    case trolleyLinePull
    case luffingRope
    case luffingLinePull
    case generalRopeCondition
    case sheaves
    case count
    
    var description: String {
        switch self {
        case .drums: return "Wire Rope Drum(s)"
        case .termination: return "Termination Points"
        case .lubrication: return "Lubrication"
        case .mainRope: return "Main Hoist Rope"
        case .mainLinePull: return "Main Hoist Line Pull"
        case .auxRope: return "Aux. Hoist Rope"
        case .auxLinePull: return "Aux. Hoist Line Pull"
        case .trolleyRope: return "Trolley Rope"
        case .trolleyLinePull: return "Trolley Rope Line Pull"
        case .luffingRope: return "Luffing Rope"
        case .luffingLinePull: return "Luffing Rope Line Pull"
        case .generalRopeCondition: return "General Rope Condition"
        case .sheaves: return "Condition of Sheaves"
        default: return ""
        }
    }
}

// MARK: - Electrical Rows
enum JCElectricalSystemRows: Int, CustomStringConvertible {
    case wiring
    case isolators
    case earthing
    case schematics
    case junctionBox
    case batteries
    case count
    
    var description: String {
        switch self {
        case .wiring: return "Wiring / Cables"
        case .isolators: return "Isolator(s)"
        case .earthing: return "Earthing"
        case .schematics: return "Schematics"
        case .junctionBox: return "Junction Box"
        case .batteries: return "Batteries"
        default: return ""
        }
    }
}


// MARK: - Safety Features Rows
enum JCSafetyFeaturesRows: Int, CustomStringConvertible {
    case emergencyStop
    case overloadSystem
    case tiltingAlarms
    case limitSwitches
    case buffers
    case anemometer
    case antiTwoBlock
    case sliUnit
    case horn
    case antiCollision
    case radiusFlags
    case count
    
    var description: String {
        switch self {
        case .emergencyStop: return "Emergency Stop Buttons / Switches"
        case .overloadSystem: return "Overload Sensors / Alarms"
        case .tiltingAlarms: return "Tilting Sensors / Alarms"
        case .limitSwitches: return "Limit Switches"
        case .buffers: return "Buffers"
        case .anemometer: return "Anemometer(s)"
        case .antiTwoBlock: return "Anti Two-Block System(s)"
        case .sliUnit: return "SLI Unit"
        case .horn: return "Horn"
        case .antiCollision: return "Anit-Collision System"
        case .radiusFlags: return "Radius Flags"
        default: return ""
        }
    }
}


// MARK: - Functions Rows
enum JCFunctionalityRows: Int, CustomStringConvertible {
    case operationalSpeed
    case operationalControls
    case functions
    case emergencyFunctions
    case manualReleaseValve
    case count
    
    var description: String {
        switch self {
        case .operationalSpeed: return "Operational Speed"
        case .operationalControls: return "Operational Controls"
        case .functions: return "Functions"
        case .emergencyFunctions: return "Emergency Functions"
        case .manualReleaseValve: return "Manual Release Valve(s)"
        default: return ""
        }
    }
}

// MARK: - Testing Rows
enum JCTestingRows: Int, CustomStringConvertible {
    case title1
    case swl1
    case appliedLoad1
    case boomLength1
    case radius1
    
    case title2
    case swl2
    case appliedLoad2
    case boomLength2
    case radius2
    
    case title3
    case swl3
    case appliedLoad3
    case boomLength3
    case radius3
    
    case title4
    case swl4
    case appliedLoad4
    case boomLength4
    case radius4
    
    case testingInfo
    case creeping
    case count
    
    var description: String {
        switch self {
        case .swl1,
             .swl2,
             .swl3,
             .swl4: return "S.W.L"
            
        case .appliedLoad1,
             .appliedLoad2,
             .appliedLoad3,
             .appliedLoad4: return "Applied Load"
            
        case .boomLength1,
             .boomLength2,
             .boomLength3,
             .boomLength4: return "Boom Length"
            
        case .radius1,
             .radius2,
             .radius3,
             .radius4: return "Radius"
            
        case .title1: return "Test 1"
        case .title2: return "Test 2"
        case .title3: return "Test 3"
        case .title4: return "Test 4 (for Aux. Hoist if applicable)"
        case .testingInfo: return "Additional Test Info."
        case .creeping: return "Observed Creeping"
        default: return ""
        }
    }
}

// MARK: - Summary Rows
enum JCApplianceSummaryRows: Int, CustomStringConvertible {
    case inspectionOutcome
    case recommendations
    case overallDefects
    case nextExam
    case nextTest
    case count
    
    var description: String {
        switch self {
        case .inspectionOutcome: return "Inspection Outcome"
        case .recommendations: return "Recommendations"
        case .overallDefects: return "Overall Defect"
        case .nextExam: return "Next Exam Date"
        case .nextTest: return "Next Test Date"
        default: return ""
        }
    }
}
