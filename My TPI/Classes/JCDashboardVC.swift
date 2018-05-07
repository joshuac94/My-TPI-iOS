//
//  JCDashboardVC.swift
//  My TPI
//
//  Created by Joshua Colley on 08/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import Lottie

class JCDashboardVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var newInsepction_Button: UIButton!
    @IBOutlet weak var appliance_Button: UIButton!
    @IBOutlet weak var animationWrapper: UIView!
    
    var appDelegate: AppDelegate!
    var interactor: JCDashboardInteractor!
    var animationView: LOTAnimationView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
        interactor = JCDashboardInteractor()
        setupUI()
        
        animationView.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    
    @IBAction func newInspection_action(_ sender: Any) {
        let menu = UIAlertController(title: "Choose new inspection type",
                                     message: nil,
                                     preferredStyle: .actionSheet)
        
        let applianceAction = UIAlertAction(title: "Lifting Appliance", style: .default) { (action) in
            self.interactor.createInspection(delegate: self.appDelegate, entityName: "ApplianceInspection")
            self.performSegue(withIdentifier: "JCApplianceChecklistVC", sender: self)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            debugPrint("Cancelled Alert Action")
        }
        
        menu.addAction(applianceAction)
        menu.addAction(cancelAction)
        
        self.present(menu, animated: true, completion: nil)
    }
    

    // MARK: - Helper Methods
    fileprivate func setupUI() {
        newInsepction_Button.layer.cornerRadius = newInsepction_Button.frame.height / 2.0
        appliance_Button.layer.cornerRadius = appliance_Button.frame.height / 2.0
        
        animationView = LOTAnimationView(name: "tick")
        animationView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                     size: CGSize(width: animationWrapper.frame.width,
                                                  height: animationWrapper.frame.height))
        
        animationWrapper.addSubview(animationView)
    }
    
    
    // MARK: - Segue Setup
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "JCApplianceChecklistVC":
            if let nc = segue.destination as? UINavigationController, let vc = nc.topViewController as? JCApplianceChecklistVC {
                vc.interactor.inspectionID = self.interactor.inspectionID
            }
        default: break
        }
    }

}
