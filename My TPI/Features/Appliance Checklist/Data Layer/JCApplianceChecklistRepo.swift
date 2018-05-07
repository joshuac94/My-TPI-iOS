//
//  JCApplianceRepo.swift
//  My TPI
//
//  Created by Joshua Colley on 09/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation
import CoreData

class JCApplianceChecklistRepo {
    
    let dbHelper: JCCoreDataHelper = JCCoreDataHelper()
    let name = "ApplianceInspection"
    
    func fetchData(delegate: AppDelegate, id: String) -> ApplianceInspection {
        guard let result = dbHelper.fetchDataWithID(delegate: delegate, entityName: name, id: id)[0] as? ApplianceInspection else {
            return ApplianceInspection()
        }
        return result
    }
    
    func updateData(delegate: AppDelegate) {
        dbHelper.updateEntity(delegate: delegate)
    }
}
