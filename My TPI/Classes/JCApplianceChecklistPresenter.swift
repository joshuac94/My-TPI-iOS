//
//  JCAppliancePresenter.swift
//  My TPI
//
//  Created by Joshua Colley on 11/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

enum JCCellType {
    case textField
    case buttons
    case title
    case textFieldBottom
    case middle
}

enum JCInputType {
    case keyboard
    case datePicker
    case picker
    case none
}

struct JCApplianceViewModel {
    var sections: [JCApplianceSectionViewModel]
}

struct JCApplianceSectionViewModel {
    var title: String
    var rows: [JCApplianceRowViewModel]
}

struct JCApplianceRowViewModel {
    var name: String
    var value: String
    var cellType: JCCellType
    var inputType: JCInputType
}

protocol JCApplianceChecklistPresenterProtocol {
    func presentData(inspection: ApplianceInspection, reload: Bool)
}

class JCApplianceChecklistPresenter: JCApplianceChecklistPresenterProtocol {
    
    weak var view: JCApplianceChecklistViewProtocol!
    
    func presentData(inspection: ApplianceInspection, reload: Bool) {
        let section1 = JCApplianceSectionViewModel(title: "1. Inspection Details",
                                                   rows: createDetailsRows(inspection: inspection))
        let section2 = JCApplianceSectionViewModel(title: "2. Documentation",
                                                   rows: createDocsRows(inspection: inspection))
        let section3 = JCApplianceSectionViewModel(title: "3. Machine Details",
                                                   rows: createMachineRows(inspection: inspection))
        let section4 = JCApplianceSectionViewModel(title: "4. General Condition",
                                                   rows: createGeneralRows(inspection: inspection))
        let section5 = JCApplianceSectionViewModel(title: "5. Mechanical Structure",
                                                   rows: createMechanicalRows(inspection: inspection))
        let section6 = JCApplianceSectionViewModel(title: "6. Wire Rope Systems",
                                                   rows: createWireRopeRows(inspection: inspection))
        let section7 = JCApplianceSectionViewModel(title: "7. Electrical Systems",
                                                   rows: createElectricalRows(inspection: inspection))
        let section8 = JCApplianceSectionViewModel(title: "8. Safety Features",
                                                   rows: createSafetyRows(inspection: inspection))
        let section9 = JCApplianceSectionViewModel(title: "9. Functionality",
                                                   rows: createFunctionsRows(inspection: inspection))
        let section10 = JCApplianceSectionViewModel(title: "10. Testing",
                                                   rows: createTestingRows(inspection: inspection))
        let section11 = JCApplianceSectionViewModel(title: "11. Summary",
                                                   rows: createSummaryRows(inspection: inspection))
        
        let model = JCApplianceViewModel(sections: [section1,
                                                    section2,
                                                    section3,
                                                    section4,
                                                    section5,
                                                    section6,
                                                    section7,
                                                    section8,
                                                    section9,
                                                    section10,
                                                    section11])
        view.presentViewModels(viewModel: model, reload: reload)
    }
    
    // MARK: - Details Rows
    fileprivate func createDetailsRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.inspectionType.description,
                                    value: inspection.inspectionType ?? "",
                                    cellType: .textField,
                                    inputType: .picker),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.clientName.description,
                                    value: inspection.clientName ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.clientAddress.description,
                                    value: inspection.clientAddress ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.dateOfInspection.description,
                                    value: inspection.dateOfInspection ?? "",
                                    cellType: .textField,
                                    inputType: .datePicker),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.inspectionNumber.description,
                                    value: inspection.inspectionNumber ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.timesheetRef.description,
                                    value: inspection.timesheetRef ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.inspectorsName.description,
                                    value: inspection.inspectorsName ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.reasonForInspection.description,
                                    value: inspection.reasonForInspection ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.isFirstTest.description,
                                    value: inspection.isFirstTest ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.isInstalledCorrectly.description,
                                    value: inspection.isInstalledCorrectly ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.location.description,
                                    value: inspection.location ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCInspectionDetailsRows.standards.description,
                                    value: inspection.standards ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard)
        ]
    }
    
    // MARK: - Docs Rows
    fileprivate func createDocsRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCDocumentationRows.previousExamCert.description,
                                    value: inspection.previousExamCert ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.previousTestCert.description,
                                    value: inspection.previousTestCert ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.ndtReportReference.description,
                                    value: inspection.ndtReportReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.mainRopeCertReference.description,
                                    value: inspection.mainRopeCertReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.auxRopeCertReference.description,
                                    value: inspection.auxRopeCertReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.trolleyRopeCertReference.description,
                                    value: inspection.trolleyRopeCertReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.luffingRopeCertReference.description,
                                    value: inspection.luffingRopeCertReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.electricalCertReference.description,
                                    value: inspection.electricalCertReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.compactTestCertReference.description,
                                    value: inspection.compactTestCertReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCDocumentationRows.maintenanceRecordsReference.description,
                                    value: inspection.maintenanceRecordsReference ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard)
        ]
    }
    
    // MARK: - Machine Details Rows
    fileprivate func createMachineRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCMachineDetailsRows.equipmentType.description,
                                    value: inspection.equipmentType ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.fleetNumber.description,
                                    value: inspection.fleetNumber ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.serialNumber.description,
                                    value: inspection.serialNumber ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.make.description,
                                    value: inspection.make ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.model.description,
                                    value: inspection.model ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.capacity.description,
                                    value: inspection.capacity ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.workingHours.description,
                                    value: inspection.workingHours ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.mileageReading.description,
                                    value: inspection.mileageReading ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.registration.description,
                                    value: inspection.registration ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.equipmentDescription.description,
                                    value: inspection.equipmentDescription ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.counterWeight.description,
                                    value: inspection.counterWeight ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCMachineDetailsRows.counterBallast.description,
                                    value: inspection.counterBallast ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard)
        ]
    }
    
    // MARK: - General Rows
    fileprivate func createGeneralRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCGeneralConditionRows.manual.description,
                                    value: inspection.manual ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.dataPlate.description,
                                    value: inspection.dataPlate ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.decals.description,
                                    value: inspection.decals ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.fireExtinguisher.description,
                                    value: inspection.fireExtinguisher ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.functionMarkings.description,
                                    value: inspection.functionMarkings ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.covers.description,
                                    value: inspection.covers ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.handRails.description,
                                    value: inspection.handRails ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.walkways.description,
                                    value: inspection.walkways ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.cabinCondition.description,
                                    value: inspection.cabinCondition ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.loadCharts.description,
                                    value: inspection.loadCharts ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.lights.description,
                                    value: inspection.lights ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.windowsMirrors.description,
                                    value: inspection.windowsMirrors ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCGeneralConditionRows.visualCondition.description,
                                    value: inspection.visualCondition ?? "",
                                    cellType: .buttons,
                                    inputType: .none)
        ]
    }
    
    // MARK: - Mechanical Rows
    fileprivate func createMechanicalRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.chassis.description,
                                    value: inspection.chassis ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.slewing.description,
                                    value: inspection.slewing ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.counterWeight.description,
                                    value: inspection.counterWeight ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.ballastWeight.description,
                                    value: inspection.ballastWeight ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.outriggers.description,
                                    value: inspection.outriggers ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.engineCondition.description,
                                    value: inspection.engineCondition ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.sparkArrestor.description,
                                    value: inspection.sparkArrestor ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.airIntake.description,
                                    value: inspection.airIntake ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.hydraulics.description,
                                    value: inspection.hydraulics ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.fluidLevels.description,
                                    value: inspection.fluidLevels ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.welding.description,
                                    value: inspection.welding ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.bolts.description,
                                    value: inspection.bolts ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.brakingSystem.description,
                                    value: inspection.brakingSystem ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.tyresWheels.description,
                                    value: inspection.tyresWheels ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.tracks.description,
                                    value: inspection.tracks ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.superstructure.description,
                                    value: inspection.superstructure ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.cylinders.description,
                                    value: inspection.cylinders ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.chains.description,
                                    value: inspection.chains ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.hookBlocks.description,
                                    value: inspection.hookBlocks ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.forks.description,
                                    value: inspection.forks ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCMechanicalStructureRows.motors.description,
                                    value: inspection.motors ?? "",
                                    cellType: .buttons,
                                    inputType: .none)
        ]
    }
    
    // MARK: - WireRope Rows
    fileprivate func createWireRopeRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.drums.description,
                                    value: inspection.drums ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.termination.description,
                                    value: inspection.termination ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.lubrication.description,
                                    value: inspection.lubrication ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.mainRope.description,
                                    value: inspection.mainDia ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.mainLinePull.description,
                                    value: inspection.mainLinePull ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.auxRope.description,
                                    value: inspection.auxDia ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.auxLinePull.description,
                                    value: inspection.auxLinePull ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.trolleyRope.description,
                                    value: inspection.trolleyDia ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.trolleyLinePull.description,
                                    value: inspection.trolleyLinePull ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.luffingRope.description,
                                    value: inspection.luffingDia ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.luffingLinePull.description,
                                    value: inspection.luffingLinePull ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.generalRopeCondition.description,
                                    value: inspection.generalRopeCondition ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCWireRopeSystemRows.sheaves.description,
                                    value: inspection.sheaves ?? "",
                                    cellType: .buttons,
                                    inputType: .none)
        ]
    }
    
    // MARK: - Electrical Rows
    fileprivate func createElectricalRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCElectricalSystemRows.wiring.description,
                                    value: inspection.wiring ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCElectricalSystemRows.isolators.description,
                                    value: inspection.isolators ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCElectricalSystemRows.earthing.description,
                                    value: inspection.earthing ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCElectricalSystemRows.schematics.description,
                                    value: inspection.schematics ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCElectricalSystemRows.junctionBox.description,
                                    value: inspection.junctionBox ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCElectricalSystemRows.batteries.description,
                                    value: inspection.batteries ?? "",
                                    cellType: .buttons,
                                    inputType: .none)
        ]
    }
    
    // MARK: - Safety Rows
    fileprivate func createSafetyRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.emergencyStop.description,
                                    value: inspection.emergencyStop ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.overloadSystem.description,
                                    value: inspection.overloadSystem ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.tiltingAlarms.description,
                                    value: inspection.tiltingAlarms ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.limitSwitches.description,
                                    value: inspection.limitSwitches ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.buffers.description,
                                    value: inspection.buffers ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.anemometer.description,
                                    value: inspection.anemometer ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.antiTwoBlock.description,
                                    value: inspection.antiTwoBlock ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.sliUnit.description,
                                    value: inspection.sliUnit ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.horn.description,
                                    value: inspection.horn ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.antiCollision.description,
                                    value: inspection.antiCollision ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCSafetyFeaturesRows.radiusFlags.description,
                                    value: inspection.radiusFlags ?? "",
                                    cellType: .buttons,
                                    inputType: .none)
        ]
    }
    
    // MARK: - Functions Rows
    fileprivate func createFunctionsRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCFunctionalityRows.operationalSpeed.description,
                                    value: inspection.operationalSpeed ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCFunctionalityRows.operationalControls.description,
                                    value: inspection.operationalControls ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCFunctionalityRows.functions.description,
                                    value: inspection.functions ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCFunctionalityRows.emergencyFunctions.description,
                                    value: inspection.emergencyFunctions ?? "",
                                    cellType: .buttons,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCFunctionalityRows.manualReleaseValve.description,
                                    value: inspection.manualReleaseValve ?? "",
                                    cellType: .buttons,
                                    inputType: .none)
        ]
    }
    
    // MARK: - Testing Rows
    fileprivate func createTestingRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCTestingRows.title1.description,
                                    value: "",
                                    cellType: .title,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCTestingRows.swl1.description,
                                    value: inspection.swl1 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.appliedLoad1.description,
                                    value: inspection.appliedLoad1 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.boomLength1.description,
                                    value: inspection.boomLength1 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.radius1.description,
                                    value: inspection.radius1 ?? "",
                                    cellType: .textFieldBottom,
                                    inputType: .keyboard),
            
            JCApplianceRowViewModel(name: JCTestingRows.title2.description,
                                    value: "",
                                    cellType: .title,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCTestingRows.swl2.description,
                                    value: inspection.swl2 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.appliedLoad2.description,
                                    value: inspection.appliedLoad2 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.boomLength2.description,
                                    value: inspection.boomLength2 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.radius2.description,
                                    value: inspection.radius2 ?? "",
                                    cellType: .textFieldBottom,
                                    inputType: .keyboard),
            
            JCApplianceRowViewModel(name: JCTestingRows.title3.description,
                                    value: "",
                                    cellType: .title,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCTestingRows.swl3.description,
                                    value: inspection.swl3 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.appliedLoad3.description,
                                    value: inspection.appliedLoad3 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.boomLength3.description,
                                    value: inspection.boomLength3 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.radius3.description,
                                    value: inspection.radius3 ?? "",
                                    cellType: .textFieldBottom,
                                    inputType: .keyboard),
            
            JCApplianceRowViewModel(name: JCTestingRows.title4.description,
                                    value: "",
                                    cellType: .title,
                                    inputType: .none),
            JCApplianceRowViewModel(name: JCTestingRows.swl4.description,
                                    value: inspection.swl4 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.appliedLoad4.description,
                                    value: inspection.appliedLoad4 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.boomLength4.description,
                                    value: inspection.boomLength4 ?? "",
                                    cellType: .middle,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.radius4.description,
                                    value: inspection.radius4 ?? "",
                                    cellType: .textFieldBottom,
                                    inputType: .keyboard),
            
            JCApplianceRowViewModel(name: JCTestingRows.testingInfo.description,
                                    value: inspection.testingInfo ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCTestingRows.creeping.description,
                                    value: inspection.creeping ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard)
        ]
    }
    
    // MARK: - Summary Rows
    fileprivate func createSummaryRows(inspection: ApplianceInspection) -> [JCApplianceRowViewModel] {
        return [
            JCApplianceRowViewModel(name: JCApplianceSummaryRows.inspectionOutcome.description,
                                    value: inspection.inspecionOutcome ?? "",
                                    cellType: .textField,
                                    inputType: .picker),
            JCApplianceRowViewModel(name: JCApplianceSummaryRows.recommendations.description,
                                    value: inspection.recommendations ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCApplianceSummaryRows.overallDefects.description,
                                    value: inspection.overallDefects ?? "",
                                    cellType: .textField,
                                    inputType: .keyboard),
            JCApplianceRowViewModel(name: JCApplianceSummaryRows.nextExam.description,
                                    value: inspection.nextExam ?? "",
                                    cellType: .textField,
                                    inputType: .datePicker),
            JCApplianceRowViewModel(name: JCApplianceSummaryRows.nextTest.description,
                                    value: inspection.nextTest ?? "",
                                    cellType: .textField,
                                    inputType: .datePicker),
        ]
    }
}
