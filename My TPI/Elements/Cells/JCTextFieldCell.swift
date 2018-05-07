//
//  JCTextFieldCell.swift
//  My TPI
//
//  Created by Joshua Colley on 10/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

@objc protocol JCTextFieldInputDelegate {
    @objc func didSelectDatePicker()
    @objc func didSelectPicker()
}

class JCTextFieldCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: JCTextField!
    @IBOutlet weak var wrapperView: UIView!
    
    var inputDelegate: JCTextFieldInputDelegate?
    
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
        
        if viewModel.inputType == .datePicker {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(changedDateValue(_:)), for: .valueChanged)
            self.valueTextField.inputView = datePicker
            self.valueTextField.inputAccessoryView = self.setupToolbar(title: "Select a Date: ", picker: .datePicker)
        }
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
        
        if picker == .datePicker {
            done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(didSelectDatePicker))
        } else if picker == .picker {
            done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(inputDelegate?.didSelectPicker))
        }
        
        done.tintColor = UIColor.white
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [labelItem, space, done]
        
        return toolbar
    }
    
    @objc fileprivate func didSelectDatePicker() {
        inputDelegate?.didSelectDatePicker()
    }
    
    @objc fileprivate func changedDateValue(_ sender: UIDatePicker) {
        let text = sender.date.displayString()
        self.valueTextField.text = text
    }
    
}
