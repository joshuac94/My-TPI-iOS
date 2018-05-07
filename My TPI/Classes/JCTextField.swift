//
//  JCTextField.swift
//  My TPI
//
//  Created by Joshua Colley on 10/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation
import UIKit

class JCTextField: UITextField {
    
    // MARK: - Properties
    var myPlaceholder: String?
    var floatingLabel: UILabel?
    var border: UIView!
    
    func setupTextField() {
        self.borderStyle = .none
        self.delegate = self
        setupBorder()
    }
    
    // MARK: - Private Methods
    fileprivate func setupBorder() {
        border = UIView()
        border.backgroundColor = UIColor(named: "CTA")
        border.frame = CGRect(origin: CGPoint(x: self.frame.width / 2, y: self.frame.height - 1),
                              size: CGSize(width: 0.0,
                                           height: 1.0))
        self.addSubview(border)
        
    }
}


// MARK: - Editing Methods
extension JCTextField {
    func toggleEditingMode() {
        if !isEditing {
            disableEditingMode()
        } else {
            enableEditingMode()
        }
    }
    
    fileprivate func enableEditingMode() {
        UIView.animate(withDuration: 0.35) {
            self.border.frame = CGRect(origin: CGPoint(x: 0, y: self.frame.height - 1),
                                       size: CGSize(width: self.frame.size.width - 0, height: 1.0))
        }
    }
    
    fileprivate func disableEditingMode() {
        UIView.animate(withDuration: 0.35) {
            self.border.frame = CGRect(origin: CGPoint(x: self.frame.width / 2, y: self.frame.height - 1),
                                       size: CGSize(width: 0.0, height: 1.0))
        }
    }
}

// MARK: - UITextFieldDelegate
extension JCTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = textField as? JCTextField {
            field.enableEditingMode()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if let field = textField as? JCTextField {
            field.enableEditingMode()
        }
    }
}
