//
//  JCApplianceListPresenter.swift
//  My TPI
//
//  Created by Joshua Colley on 13/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCApplianceListPresenterProtocol {
    func displayInspections(inspections: [ApplianceInspection])
}

class JCApplianceListPresenter: JCApplianceListPresenterProtocol {
    
    weak var view: JCApplianceListViewProtocol!
    
    func displayInspections(inspections: [ApplianceInspection]) {
        let models = inspections.flatMap { (inspection) -> JCApplianceListViewModel? in
            let outcome = inspection.inspecionOutcome
            let model = JCApplianceListViewModel()
            
            model.inspectionID = inspection.inspectionID
            model.assetNumber = inspection.fleetNumber == "" ? inspection.fleetNumber : inspection.serialNumber
            model.clientName = inspection.clientName
            model.date = inspection.dateOfInspection ?? ""
            model.iconString = outcome ?? "Incomplete"
            
            return model
        }
        view.setupTable(inspections: models)
    }
}
