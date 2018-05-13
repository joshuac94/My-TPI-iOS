//
//  JCApplianceChecklistVC.swift
//  My TPI
//
//  Created by Joshua Colley on 08/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

protocol JCApplianceChecklistViewProtocol: class {
    func presentViewModels(viewModel: JCApplianceViewModel, reload: Bool)
}

class JCApplianceChecklistVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var previousChevron: UIButton!
    @IBOutlet weak var nextChevron: UIButton!
    
    let sectionPicker = UIPickerView()
    
    let interactor: JCApplianceChecklistInteractor = JCApplianceChecklistInteractor()
    let presenter: JCApplianceChecklistPresenter = JCApplianceChecklistPresenter()
    
    var appDelegate: AppDelegate!
    var viewModel: JCApplianceViewModel!
    
    var currentSection: Int = 0 {
        didSet {
            reloadSection()
        }
    }
    
    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        presenter.view = self
        interactor.presenter = presenter
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        interactor.fetchData(delegate: appDelegate)

        self.setupFAB(icon: UIImage(named: "contract")!, delegate: self)
        fabIsVisible(false)
        
        self.setupTapToDismiss()
        UIApplication.shared.statusBarStyle = .lightContent
        
        currentSection = 0
        
        sectionPicker.delegate = self
        titleField.inputView = sectionPicker
        titleField.inputAccessoryView = self.setupToolbar(title: "Select a Section: ", picker: .picker)
        
        
        // Swipe Gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
        // TEST
//        NotificationCenter.default.addObserver( self, #selector(didShowKeyboard(_:)),
//                                                name: UIKeyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didShowKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    
    // MARK: - Helper Methods
    @objc fileprivate func swipeHandler(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                if self.currentSection > JCApplianceSections.inspectionDetails.rawValue {
                    self.currentSection -= 1
                }
            case UISwipeGestureRecognizerDirection.right:
                if self.currentSection < JCApplianceSections.summary.rawValue {
                    self.currentSection += 1
                }
            default: break
            }
        }
    }
    
    fileprivate func reloadSection() {
        if currentSection == JCApplianceSections.inspectionDetails.rawValue {
            previousChevron.isEnabled = false
            previousChevron.alpha = 0.0
            nextChevron.isEnabled = true
            nextChevron.alpha = 1.0
            fabFadeOut()
        } else if currentSection == JCApplianceSections.summary.rawValue {
            nextChevron.isEnabled = false
            nextChevron.alpha = 0.0
            previousChevron.isEnabled = true
            previousChevron.alpha = 1.0
            fabFadeIn()
        } else {
            previousChevron.isEnabled = true
            previousChevron.alpha = 1.0
            nextChevron.isEnabled = true
            nextChevron.alpha = 1.0
            fabFadeOut()
        }
        titleField.text = viewModel.sections[currentSection].title
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func cancelBtn_action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn_action(_ sender: Any) {
        
    }
    
    @IBAction func nextChevronAction(_ sender: Any) {
        self.currentSection += 1
    }
    
    @IBAction func previousChevronAction(_ sender: Any) {
        self.currentSection -= 1
    }
    
    // MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "JCApplianceReviewSegue":
            if let vc = segue.destination as? JCApplianceReviewVC {
                vc.interactor.inspection = interactor.inspection
            }
        default: return
        }
    }
}


// MARK: - JCApplianceChecklistViewProtocol
extension JCApplianceChecklistVC: JCApplianceChecklistViewProtocol {
    func presentViewModels(viewModel: JCApplianceViewModel, reload: Bool) {
        self.viewModel = viewModel
        if reload {
            tableView.reloadData()
        }
    }
}


// MARK: - Tableview Data Source
extension JCApplianceChecklistVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "JCTextFieldCell", bundle: nil), forCellReuseIdentifier: "textFieldCell")
        tableView.register(UINib(nibName: "JCButtonsCell", bundle: nil), forCellReuseIdentifier: "buttonsCell")
        tableView.register(UINib(nibName: "JCBottomCell", bundle: nil), forCellReuseIdentifier: "bottomCell")
        tableView.register(UINib(nibName: "JCTitleCell", bundle: nil), forCellReuseIdentifier: "titleCell")
        tableView.register(UINib(nibName: "JCMiddleCell", bundle: nil), forCellReuseIdentifier: "middleCell")
        
        let rowModel = viewModel.sections[currentSection].rows[indexPath.row]
        
        switch rowModel.cellType {
        case .buttons:
            if let buttonCell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as? JCButtonsCell {
                buttonCell.setButtonsToNeutral()
                buttonCell.delegate = self
                buttonCell.row = indexPath.row
                buttonCell.bindData(viewModel: rowModel)
                return buttonCell
            }
            
        case .textField:
            if let textFieldCell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as? JCTextFieldCell {
                textFieldCell.valueTextField.delegate = self
                textFieldCell.inputDelegate = self
                textFieldCell.valueTextField.tag = indexPath.row
                textFieldCell.bindData(viewModel: rowModel)
                return textFieldCell
            }
            
        case .textFieldBottom:
            if let bottomCell = tableView.dequeueReusableCell(withIdentifier: "bottomCell", for: indexPath) as? JCBottomCell {
                bottomCell.valueField.delegate = self
                bottomCell.valueField.tag = indexPath.row
                bottomCell.bindData(viewModel: rowModel)
                return bottomCell
            }
        
        case .title:
            if let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? JCTitleCell {
                titleCell.bindData(viewModel: rowModel)
                return titleCell
            }
        
        case .middle:
            if let middleCell = tableView.dequeueReusableCell(withIdentifier: "middleCell", for: indexPath) as? JCMiddleCell {
                middleCell.valueTextField.delegate = self
                middleCell.valueTextField.tag = indexPath.row
                middleCell.bindData(viewModel: rowModel)
                return middleCell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.currentSection {
            case JCApplianceSections.inspectionDetails.rawValue: return JCInspectionDetailsRows.count.rawValue
            case JCApplianceSections.machineDetails.rawValue: return JCMachineDetailsRows.count.rawValue
            case JCApplianceSections.documentation.rawValue: return JCDocumentationRows.count.rawValue
            case JCApplianceSections.generalCondition.rawValue: return JCGeneralConditionRows.count.rawValue
            case JCApplianceSections.mechanicalStructure.rawValue: return JCMechanicalStructureRows.count.rawValue
            case JCApplianceSections.wireRopeSystem.rawValue: return JCWireRopeSystemRows.count.rawValue
            case JCApplianceSections.electricalSystem.rawValue: return JCElectricalSystemRows.count.rawValue
            case JCApplianceSections.safetyDevices.rawValue: return JCSafetyFeaturesRows.count.rawValue
            case JCApplianceSections.functionality.rawValue: return JCFunctionalityRows.count.rawValue
            case JCApplianceSections.testing.rawValue: return JCTestingRows.count.rawValue
            case JCApplianceSections.summary.rawValue: return JCApplianceSummaryRows.count.rawValue
            default: return 0
        }
    }
}


// MARK: - Tableview Delegate
extension JCApplianceChecklistVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[currentSection].rows[indexPath.row].cellType {
        case .buttons: return 135
        case .textField: return 75
        case .textFieldBottom: return 75
        case .middle: return 75
        case .title: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


// MARK: - UITextField Delegate
extension JCApplianceChecklistVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        interactor.saveData(delegate: appDelegate,
                            row: textField.tag,
                            section: self.currentSection,
                            text: textField.text ?? "")
        self.dismissKeyboard()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let selectedTextView = textField as? JCTextField {
            selectedTextView.toggleEditingMode()
            tableView.scrollToRow(at: IndexPath(row: selectedTextView.tag, section: 0), at: .none, animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if let selectedTextView = textField as? JCTextField {
            selectedTextView.toggleEditingMode()
        }
    }
    
    @objc func didShowKeyboard(_ note: NSNotification) {
        if let newFrame = (note.userInfo?[ UIKeyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsetsMake( 0, 0, newFrame.height, 0 )
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
}


// MARK: - FAB Delegate
extension JCApplianceChecklistVC: JCFloatingActionButtonDelegate {
    func didClickFAB() {
        performSegue(withIdentifier: "JCApplianceReviewSegue", sender: self)
    }
}


// MARK: - Picker Delegate & Data Source
extension JCApplianceChecklistVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return JCApplianceSections.count.rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return JCApplianceSections(rawValue: row)?.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentSection = row
        self.dismissKeyboard()
    }
}


// MARK: - JCButtonsCell Delegate
extension JCApplianceChecklistVC: JCButtonsCellDelegate {
    func didSelectButton(text: String, row: Int) {
        interactor.saveData(delegate: appDelegate,
                            row: row,
                            section: currentSection,
                            text: text)
    }
}


// MARK: - Date Picker Method
extension JCApplianceChecklistVC: JCTextFieldInputDelegate {
    
    fileprivate func setupToolbar(title: String, picker: JCInputType) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolbar.barTintColor = UIColor.darkGray
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 50))
        label.text = title
        label.textColor = UIColor.white
        let labelItem = UIBarButtonItem(customView: label)
        var done: UIBarButtonItem!
        
        if picker == .picker {
            done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(didSelectPicker))
        }
        
        done.tintColor = UIColor.white
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [labelItem, space, done]
        
        return toolbar
    }
    
    func didChangeText(text: String, row: Int) {
        interactor.saveData(delegate: appDelegate,
                            row: row,
                            section: currentSection,
                            text: text)
    }
    
    @objc func didSelectPicker() {
        self.dismissKeyboard()
    }
    
    @objc func didSelectDatePicker() {
        self.dismissKeyboard()
    }
}
