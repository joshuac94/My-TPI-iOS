//
//  JCApplianceReviewPresenter.swift
//  My TPI
//
//  Created by Joshua Colley on 15/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCApplianceReviewPresenterProtocol {
    func presentInspectionData(appliance: ApplianceInspection)
}

class JCApplianceReviewPresenter: JCApplianceReviewPresenterProtocol {
    var view: JCApplianceReviewViewProtocol!
    
    func presentInspectionData(appliance: ApplianceInspection) {
        var viewModel = JCApplianceReviewViewModel()
        
//        let outcome = JCInspectionOutcome(rawValue: Int(appliance.inspecionOutcome!)!)?.description ?? JCInspectionOutcome.incomplete.description
//        viewModel.outcome = outcome
        view.showInspectionReview(model: viewModel)
    }
}
