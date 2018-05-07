//
//  JCApplianceReviewInteractor.swift
//  My TPI
//
//  Created by Joshua Colley on 15/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCApplianceReviewInteractorProtocol {
    func fetchInspectionData()
}

class JCApplianceReviewInteractor: JCApplianceReviewInteractorProtocol {
    var inspection: ApplianceInspection!
    var presenter: JCApplianceReviewPresenterProtocol!
    
    func fetchInspectionData() {
        presenter.presentInspectionData(appliance: inspection)
    }
}
