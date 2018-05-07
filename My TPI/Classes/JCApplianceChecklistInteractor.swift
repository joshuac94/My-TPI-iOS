//
//  JCApplianceChecklistInteractor.swift
//  My TPI
//
//  Created by Joshua Colley on 08/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCApplianceChecklistInteractorProtocol {
    func fetchData(delegate: AppDelegate)
    func updateData(delegate: AppDelegate)
    func saveData(delegate: AppDelegate, row: Int, section: Int, text: String)
}

class JCApplianceChecklistInteractor: JCApplianceChecklistInteractorProtocol {
    
    let repo: JCApplianceChecklistRepo = JCApplianceChecklistRepo()
    var presenter: JCApplianceChecklistPresenter!
    
    var inspectionID: String = ""
    var inspection: ApplianceInspection!
    
    func fetchData(delegate: AppDelegate) {
        let result = repo.fetchData(delegate: delegate, id: inspectionID)
        inspection = result
        presenter.presentData(inspection: result, reload: true)
    }
    
    func updateData(delegate: AppDelegate) {
        repo.updateData(delegate: delegate)
    }
    
    func saveData(delegate: AppDelegate, row: Int, section: Int, text: String) {
        if let section = JCApplianceSections(rawValue: section) {
            switch section {
            case .inspectionDetails: saveInspectionDetail(row: row, text: text)
            case .documentation: saveDocumentation(row: row, text: text)
            case .machineDetails: saveMachineDetail(row: row, text: text)
            case .generalCondition: saveGeneralInfo(row: row, text: text)
            case .mechanicalStructure: saveMechanicalInfo(row: row, text: text)
            case .wireRopeSystem: saveWireRope(row: row, text: text)
            case .electricalSystem: saveElectricalInfo(row: row, text: text)
            case .safetyDevices: saveSafetyInfo(row: row, text: text)
            case .functionality: saveFunctionalityInfo(row: row, text: text)
            case .testing: saveTestingInfo(row: row, text: text)
            case .summary: saveSummaryInfo(row: row, text: text)
            default: break
            }
        }
        repo.updateData(delegate: delegate)
        presenter.presentData(inspection: inspection, reload: false)
    }
    
    // MARK: - Save Methods
    fileprivate func saveInspectionDetail(row: Int, text: String) {
        if let row = JCInspectionDetailsRows(rawValue: row) {
            switch row {
            case .inspectionType: inspection.inspectionType = text
            case .clientName: inspection.clientName = text
            case .clientAddress: inspection.clientAddress = text
            case .dateOfInspection: inspection.dateOfInspection = text
            case .inspectionNumber:  inspection.inspectionNumber = text
            case .timesheetRef: inspection.timesheetRef = text
            case .inspectorsName:  inspection.inspectorsName = text
            case .reasonForInspection: inspection.reasonForInspection = text
            case .isFirstTest: inspection.isFirstTest = text
            case .isInstalledCorrectly: inspection.isInstalledCorrectly = text
            case .location: inspection.location = text
            case .standards: inspection.standards = text
            default: break
            }
        }
    }
    
    fileprivate func saveDocumentation(row: Int, text: String) {
        if let row = JCDocumentationRows(rawValue: row) {
            switch row {
            case .previousExamCert: inspection.previousExamCert = text
            case .previousTestCert: inspection.previousTestCert = text
            case .ndtReportReference: inspection.ndtReportReference = text
            case .mainRopeCertReference: inspection.mainRopeCertReference = text
            case .auxRopeCertReference: inspection.auxRopeCertReference = text
            case .trolleyRopeCertReference: inspection.trolleyRopeCertReference = text
            case .luffingRopeCertReference: inspection.luffingRopeCertReference = text
            case .electricalCertReference: inspection.electricalCertReference = text
            case .compactTestCertReference: inspection.compactTestCertReference = text
            case .maintenanceRecordsReference: inspection.maintenanceRecordsReference = text
            default: break
            }
        }
    }
    
    fileprivate func saveMachineDetail(row: Int, text: String) {
        if let row = JCMachineDetailsRows(rawValue: row) {
            switch row {
            case .equipmentType: inspection.equipmentType = text
            case .fleetNumber: inspection.fleetNumber = text
            case .serialNumber: inspection.serialNumber = text
            case .make: inspection.make = text
            case .model: inspection.model = text
            case .capacity: inspection.capacity = text
            case .workingHours: inspection.workingHours = text
            case .mileageReading: inspection.mileageReading = text
            case .registration: inspection.registration = text
            case .equipmentDescription: inspection.equipmentDescription = text
            case .counterWeight: inspection.counterWeight = text
            case .counterBallast: inspection.counterBallast = text
            default: break
            }
        }
    }
    
    fileprivate func saveGeneralInfo(row: Int, text: String) {
        if let row = JCGeneralConditionRows(rawValue: row) {
            switch row {
            case .manual: inspection.manual = text
            case .dataPlate: inspection.dataPlate = text
            case .decals: inspection.decals = text
            case .fireExtinguisher: inspection.fireExtinguisher = text
            case .functionMarkings: inspection.functionMarkings = text
            case .covers: inspection.covers = text
            case .handRails: inspection.handRails = text
            case .walkways: inspection.walkways = text
            case .cabinCondition: inspection.cabinCondition = text
            case .loadCharts: inspection.loadCharts = text
            case .lights: inspection.lights = text
            case .windowsMirrors: inspection.windowsMirrors = text
            case .visualCondition: inspection.visualCondition = text
            default: break
            }
        }
    }
    
    fileprivate func saveMechanicalInfo(row: Int, text: String) {
        if let row = JCMechanicalStructureRows(rawValue: row) {
            switch row {
            case .chassis: inspection.chassis = text
            case .slewing: inspection.slewing = text
            case .counterWeight: inspection.counterWeight = text
            case .ballastWeight: inspection.ballastWeight = text
            case .outriggers: inspection.outriggers = text
            case .engineCondition: inspection.engineCondition = text
            case .sparkArrestor: inspection.sparkArrestor = text
            case .airIntake: inspection.airIntake = text
            case .hydraulics: inspection.hydraulics = text
            case .fluidLevels: inspection.fluidLevels = text
            case .welding: inspection.welding = text
            case .bolts: inspection.bolts = text
            case .brakingSystem: inspection.brakingSystem = text
            case .tyresWheels: inspection.tyresWheels = text
            case .tracks: inspection.tracks = text
            case .superstructure: inspection.superstructure = text
            case .cylinders: inspection.cylinders = text
            case .chains: inspection.chains = text
            case .hookBlocks: inspection.hookBlocks = text
            case .forks: inspection.forks = text
            case .motors: inspection.motors = text
            default: break
            }
        }
    }
    
    fileprivate func saveWireRope(row: Int, text: String) {
        if let row = JCWireRopeSystemRows(rawValue: row) {
            switch row {
            case .drums: inspection.drums = text
            case .termination: inspection.termination = text
            case .lubrication: inspection.lubrication = text
            case .mainRope: inspection.mainDia = text
            case .mainLinePull: inspection.mainLinePull = text
            case .auxRope: inspection.auxDia = text
            case .auxLinePull: inspection.auxLinePull = text
            case .trolleyRope: inspection.trolleyDia = text
            case .trolleyLinePull: inspection.trolleyLinePull = text
            case .luffingRope: inspection.luffingDia = text
            case .luffingLinePull: inspection.luffingLinePull = text
            case .generalRopeCondition: inspection.generalRopeCondition = text
            case .sheaves: inspection.sheaves = text
            default: break
            }
        }
    }
    
    fileprivate func saveElectricalInfo(row: Int, text: String) {
        if let row = JCElectricalSystemRows(rawValue: row) {
            switch row {
            case .wiring: inspection.wiring = text
            case .isolators: inspection.isolators = text
            case .earthing: inspection.earthing = text
            case .schematics: inspection.schematics = text
            case .junctionBox: inspection.junctionBox = text
            case .batteries: inspection.batteries = text
            default: break
            }
        }
    }
    
    fileprivate func saveSafetyInfo(row: Int, text: String) {
        if let row = JCSafetyFeaturesRows(rawValue: row) {
            switch row {
            case .emergencyStop: inspection.emergencyStop = text
            case .overloadSystem: inspection.overloadSystem = text
            case .tiltingAlarms: inspection.tiltingAlarms = text
            case .limitSwitches: inspection.limitSwitches = text
            case .buffers: inspection.buffers = text
            case .anemometer: inspection.anemometer = text
            case .antiTwoBlock: inspection.antiTwoBlock = text
            case .sliUnit: inspection.sliUnit = text
            case .horn: inspection.horn = text
            case .antiCollision: inspection.antiCollision = text
            case .radiusFlags: inspection.radiusFlags = text
            default: break
            }
        }
    }
    
    fileprivate func saveFunctionalityInfo(row: Int, text: String) {
        if let row = JCFunctionalityRows(rawValue: row) {
            switch row {
            case .operationalSpeed: inspection.operationalSpeed = text
            case .operationalControls: inspection.operationalControls = text
            case .functions: inspection.functions = text
            case .emergencyFunctions: inspection.emergencyFunctions = text
            case .manualReleaseValve: inspection.manualReleaseValve = text
            default: break
            }
        }
    }
    
    fileprivate func saveTestingInfo(row: Int, text: String) {
        if let row = JCTestingRows(rawValue: row) {
            switch row {
            case .swl1: inspection.swl1 = text
            case .appliedLoad1: inspection.appliedLoad1 = text
            case .boomLength1: inspection.boomLength1 = text
            case .radius1: inspection.radius1 = text
                
            case .swl2: inspection.swl2 = text
            case .appliedLoad2: inspection.appliedLoad2 = text
            case .boomLength2: inspection.boomLength2 = text
            case .radius2: inspection.radius2 = text
                
            case .swl3: inspection.swl3 = text
            case .appliedLoad3: inspection.appliedLoad3 = text
            case .boomLength3: inspection.boomLength3 = text
            case .radius3: inspection.radius3 = text
                
            case .swl4: inspection.swl4 = text
            case .appliedLoad4: inspection.appliedLoad4 = text
            case .boomLength4: inspection.boomLength4 = text
            case .radius4: inspection.radius4 = text
                
            case .testingInfo: inspection.testingInfo = text
            case .creeping: inspection.creeping = text
            default: break
            }
        }
    }
    
    fileprivate func saveSummaryInfo(row: Int, text: String) {
        if let row = JCApplianceSummaryRows(rawValue: row) {
            switch row {
            case .inspectionOutcome: inspection.inspecionOutcome = text
            case .recommendations: inspection.recommendations = text
            case .overallDefects: inspection.overallDefects = text
            case .nextExam: inspection.nextExam = text
            case .nextTest: inspection.nextTest = text
            default: break
            }
        }
    }
}

