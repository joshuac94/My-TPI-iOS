//
//  JCDashboardInteractor.swift
//  My TPI
//
//  Created by Joshua Colley on 13/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCDashboardInteractorProtocol {
    func createInspection(delegate: AppDelegate, entityName: String)
}

class JCDashboardInteractor: JCDashboardInteractorProtocol {
    var inspectionID: String = ""
    let dbHelper = JCCoreDataHelper()
    
    func createInspection(delegate: AppDelegate, entityName: String) {
        inspectionID = dbHelper.createEntity(delegate: delegate, entityName: entityName)
    }
}
