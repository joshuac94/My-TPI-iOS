//
//  JCApplianceReviewVC.swift
//  My TPI
//
//  Created by Joshua Colley on 15/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

protocol JCApplianceReviewViewProtocol {
    func showInspectionReview(model: JCApplianceReviewViewModel)
}

class JCApplianceReviewVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var reviewButton: UIButton!
    
    let interactor: JCApplianceReviewInteractor = JCApplianceReviewInteractor()
    let presenter: JCApplianceReviewPresenter = JCApplianceReviewPresenter()
    
    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        presenter.view = self
        interactor.presenter = presenter
        interactor.fetchInspectionData()

        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: Actions
extension JCApplianceReviewVC {
    
    @IBAction func reviewButton_action(_ sender: Any) {
    }
}

// MARK: - View Protocol
extension JCApplianceReviewVC: JCApplianceReviewViewProtocol {
    func showInspectionReview(model: JCApplianceReviewViewModel) {
//        self.title = model.outcome!
    }
}
