//
//  JCTextFieldCell.swift
//  My TPI
//
//  Created by Joshua Colley on 10/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

@objc protocol JCTextFieldInputDelegate {
    @objc func didPressDone()
    @objc func didChangeText(text: String, row: Int)
}

class JCTextFieldCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: JCTextField!
    @IBOutlet weak var wrapperView: UIView!
    
    var inputDelegate: JCTextFieldInputDelegate?
    var row: Int!
    var inputType: JCInputType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueTextField.setupTextField()

        wrapperView.layer.cornerRadius = 5.0
        wrapperView.layer.shadowRadius = 0.45
        wrapperView.layer.shadowColor = UIColor.lightGray.cgColor
        wrapperView.layer.shadowOpacity = 0.5
        wrapperView.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(viewModel: JCApplianceRowViewModel) {
        self.titleLabel.text = viewModel.name
        self.valueTextField.text = viewModel.value
        self.row = valueTextField.tag
        self.inputType = viewModel.inputType
        
        switch self.inputType {
        case .datePicker: addDatePickerTarget()
        case .keyboard: addKeyboardTarget()
        case .typePicker: addPickerTarget()
        case .reasonPicker: addPickerTarget()
        case .questionPicker: addPickerTarget()
        case .outcomePicker: break
        case .equipmentPicker: addPickerTarget()
        case .none: break
        }
    }
}


// MARK: - Helper Methods
extension JCTextFieldCell {
    fileprivate func addDatePickerTarget() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changedDateValue(_:)), for: .valueChanged)
        
        self.valueTextField.inputView = datePicker
        self.valueTextField.inputAccessoryView = self.setupToolbar(title: "Select a Date: ", picker: .datePicker)
    }
    
    fileprivate func addKeyboardTarget() {
        valueTextField.inputView = nil
        valueTextField.inputAccessoryView = nil
        valueTextField.reloadInputViews()
        valueTextField.addTarget(self, action: #selector(changedTextValue(_:)), for: .editingChanged)
    }
    
    fileprivate func addPickerTarget() {
        let picker = UIPickerView()
        picker.delegate = self
        self.valueTextField.inputView = picker
        self.valueTextField.inputAccessoryView = self.setupToolbar(title: "Select a Value: ", picker: .typePicker)
    }
}


// MARK: - Date Picker Method
extension JCTextFieldCell {
    fileprivate func setupToolbar(title: String, picker: JCInputType) -> UIToolbar {
        let width = UIScreen.main.bounds.width
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        toolbar.barTintColor = UIColor.darkGray
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width / 3, height: 50))
        label.text = title
        label.textColor = UIColor.white
        
        let labelItem = UIBarButtonItem(customView: label)
        var done: UIBarButtonItem!
        done = UIBarButtonItem(title: "Done",
                               style: .done,
                               target: self,
                               action: #selector(didPressDone))
        
        done.tintColor = UIColor.white
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [labelItem, space, done]
        
        return toolbar
    }
    
    @objc fileprivate func didPressDone() {
        inputDelegate?.didPressDone()
    }
    
    @objc fileprivate func changedDateValue(_ sender: UIDatePicker) {
        let text = sender.date.displayString()
        self.valueTextField.text = text
    }
    
    @objc fileprivate func changedTextValue(_ sender: JCTextField) {
        var text = sender.text ?? ""
        text = text == "Please Select" ? "" : text
        inputDelegate?.didChangeText(text: text, row: self.row)
    }
}


// MARK: - Picker Delegate & Data Source
extension JCTextFieldCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.inputType {
        case .typePicker: return JCInspectionType.count.rawValue
        case .keyboard: return 0
        case .datePicker: return 0
        case .reasonPicker: return JCReason.count.rawValue
        case .questionPicker: return JCBasicResponse.count.rawValue
        case .outcomePicker: return 0
        case .equipmentPicker: return JCApplianceType.count.rawValue
        case .none: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.inputType {
        case .typePicker: return JCInspectionType(rawValue: row)?.description
        case .keyboard: return ""
        case .datePicker: return ""
        case .reasonPicker: return JCReason(rawValue: row)?.description
        case .questionPicker: return JCBasicResponse(rawValue: row)?.description
        case .outcomePicker: return ""
        case .equipmentPicker: return JCApplianceType(rawValue: row)?.description
        case .none: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var text = ""
        switch self.inputType {
        case .typePicker: text = JCInspectionType(rawValue: row)?.description ?? ""
        case .questionPicker: text = JCBasicResponse(rawValue: row)?.description ?? ""
        case .reasonPicker: text = JCReason(rawValue: row)?.description ?? ""
        case .equipmentPicker: text = JCApplianceType(rawValue: row)?.description ?? ""
        default: break
        }
        text = text == "Please Select" ? "" : text
        self.valueTextField.text = text
        inputDelegate?.didChangeText(text: text, row: self.row)
    }
}
