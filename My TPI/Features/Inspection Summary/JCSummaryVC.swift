//
//  JCSummaryVC.swift
//  My TPI
//
//  Created by Joshua Colley on 07/05/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class JCSummaryVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var outcomeImage: UIImageView!
    
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var assetNumberLabel: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var viewCertButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var viewModel: JCApplianceListViewModel?
    
    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVC()
    }
    
    // MARK: - Actions
    @IBAction func viewCertificateAction(_ sender: Any) {
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "editInspectionSegue", sender: self)
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    fileprivate func setupVC() {
        popupView.layer.cornerRadius = 15.0
        viewCertButton.layer.cornerRadius = viewCertButton.frame.height / 2
        
        if let viewModel = viewModel {
            outcomeLabel.text = viewModel.iconString
            outcomeImage.image = UIImage(named: viewModel.iconString)
            assetNumberLabel.text = viewModel.assetNumber
            dateLabel.text = viewModel.date
            locationLabel.text = "Manchester, GB"
        }
        
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nc = segue.destination as? UINavigationController,
           let vc = nc.topViewController as? JCApplianceChecklistVC,
           let id = viewModel?.inspectionID {
            
            vc.interactor.inspectionID = id
        }
    }
    
}
