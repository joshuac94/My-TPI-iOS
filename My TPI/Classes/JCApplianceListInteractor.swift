//
//  JCApplianceListInteractor.swift
//  My TPI
//
//  Created by Joshua Colley on 10/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCApplianceListInteractorProtocol {
    func fetchData(delegate: AppDelegate)
    func deleteEntity(delegate: AppDelegate, id: String)
    func createInspection(delegate: AppDelegate, entityName: String)
}

class JCApplianceListInteractor {
    
    var inspectionID: String = ""
    let dbHelper: JCCoreDataHelper = JCCoreDataHelper()
    var presenter: JCApplianceListPresenterProtocol!
    
    func fetchData(delegate: AppDelegate) {
        guard let result = dbHelper.fetchAllData(delegate: delegate, entityName: "ApplianceInspection") as? [ApplianceInspection] else {
            return
        }
        presenter.displayInspections(inspections: result)
    }
    
    func deleteEntity(delegate: AppDelegate, id: String) {
        dbHelper.deleteEntity(delegate: delegate, entityName: "ApplianceInspection", id: id)
        fetchData(delegate: delegate)
    }
    
    func createInspection(delegate: AppDelegate, entityName: String) {
        inspectionID = dbHelper.createEntity(delegate: delegate, entityName: entityName)
        fetchData(delegate: delegate)
    }
}

