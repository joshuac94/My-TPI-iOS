//
//  JCApplianceListVC.swift
//  My TPI
//
//  Created by Joshua Colley on 10/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

protocol JCApplianceListViewProtocol: class {
    func setupTable(inspections: [JCApplianceListViewModel])
}

class JCApplianceListVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: JCApplianceListInteractor = JCApplianceListInteractor()
    var presenter: JCApplianceListPresenter = JCApplianceListPresenter()
    
    var appDelegate: AppDelegate!
    var selectedIndex: Int = -1
    
    var viewModels: [JCApplianceListViewModel]!
    
    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        presenter.view = self
        interactor.presenter = presenter
        
        tableView.delegate = self
        tableView.dataSource = self

        self.setupFAB(icon: UIImage(named: "add-button")!, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchData(delegate: appDelegate)
    }
    
    // MARK: Actions
    @IBAction func backButton_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Conform to JCApplianceListViewProtocol
extension JCApplianceListVC: JCApplianceListViewProtocol {
    func setupTable(inspections: [JCApplianceListViewModel]) {
        self.viewModels = inspections
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate
extension JCApplianceListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        if viewModels[indexPath.row].iconString == JCInspectionOutcome.incomplete.rawValue {
            performSegue(withIdentifier: "List-ApplianceChecklistVC", sender: self)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "SummaryVC") as? JCSummaryVC {
                vc.viewModel = viewModels[indexPath.row]
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            guard let id = self.viewModels[indexPath.row].inspectionID else {
                return
            }
            self.interactor.deleteEntity(delegate: self.appDelegate, id: id)
            tableView.reloadData()
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - TableView Data Source
extension JCApplianceListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "JCApplianceListCell", bundle: nil), forCellReuseIdentifier: "applianceListCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "applianceListCell") as? JCApplianceListCell else {
            return UITableViewCell()
        }
        cell.bindData(viewModel: viewModels[indexPath.row])
        return cell
    }
}

// MARK: - Prepare for Segue
extension JCApplianceListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "List-ApplianceChecklistVC":
            if let nc = segue.destination as? UINavigationController, let vc = nc.topViewController as? JCApplianceChecklistVC {
                vc.interactor.inspectionID = viewModels[selectedIndex].inspectionID!
            }
        default: break
        }
    }
}

// MARK: - FAB Delegate
extension JCApplianceListVC: JCFloatingActionButtonDelegate {
    @objc func didClickFAB() {
        self.interactor.createInspection(delegate: self.appDelegate, entityName: "ApplianceInspection")
        selectedIndex = viewModels.count - 1
        self.performSegue(withIdentifier: "List-ApplianceChecklistVC", sender: self)
    }
}
