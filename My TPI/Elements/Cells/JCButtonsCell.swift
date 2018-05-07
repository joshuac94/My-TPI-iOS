//
//  JCButtonsCell.swift
//  My TPI
//
//  Created by Joshua Colley on 28/04/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

protocol JCButtonsCellDelegate: class {
    func didSelectButton(text: String, row: Int)
}

enum JCChecklistButtons: Int, CustomStringConvertible {
    case pass
    case fail
    case notApplicable
    case notAvailable
    case noSelection
    
    var description: String {
        switch self {
        case .pass: return "Satisfactory"
        case .fail: return "Unsatisfactory"
        case .notApplicable: return "Not Applicable"
        case .notAvailable: return "Not Available"
        case .noSelection: return ""
        }
    }
}

class JCButtonsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var checklistButtons: [UIButton]!
    @IBOutlet weak var wrapperView: UIView!
    
    var delegate: JCButtonsCellDelegate?
    var row: Int!
    
    var selectedIndex: JCChecklistButtons = .noSelection {
        didSet {
            self.setSelectedButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrapperView.layer.cornerRadius = 5.0
        wrapperView.layer.shadowRadius = 0.45
        wrapperView.layer.shadowColor = UIColor.lightGray.cgColor
        wrapperView.layer.shadowOpacity = 0.5
        wrapperView.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        
        checklistButtons.forEach { (button) in
            let index = button.tag
            button.setTitle(JCChecklistButtons.init(rawValue: index)?.description, for: .normal)
            button.layer.cornerRadius = 5.0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checklistButtonAction(_ sender: UIButton) {
        self.setButtonsToNeutral()
        if let index = JCChecklistButtons(rawValue: sender.tag) {
            if index == self.selectedIndex {
                self.setButtonsToNeutral()
                self.selectedIndex = .noSelection
            } else {
                switch index {
                case .pass: selectedIndex = .pass
                case .fail: selectedIndex = .fail
                case .notAvailable: selectedIndex = .notAvailable
                case .notApplicable: selectedIndex = .notApplicable
                case .noSelection:
                    self.setButtonsToNeutral()
                    self.selectedIndex = .noSelection
                }
            }
            delegate?.didSelectButton(text: self.selectedIndex.description, row: self.row)
        }
    }
    
    func setButtonsToNeutral() {
        self.checklistButtons.forEach { (button) in
            button.backgroundColor = UIColor(named: "Grey")
            button.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    func bindData(viewModel: JCApplianceRowViewModel) {
        self.titleLabel.text = viewModel.name
        if let value = JCChecklistResponse(rawValue: viewModel.value) {
            switch value {
            case .satisfactory: self.selectedIndex = .pass
            case .unsatisfactory: self.selectedIndex = .fail
            case .notAvailable: self.selectedIndex = .notAvailable
            case .notApplicable: self.selectedIndex = .notApplicable
            case .empty: self.selectedIndex = .noSelection
            }
        }
    }
    
    fileprivate func setSelectedButton() {
        self.setButtonsToNeutral()
        switch selectedIndex {
        case .pass:
            self.checklistButtons[JCChecklistButtons.pass.rawValue].backgroundColor = UIColor(named: "Pass")
            self.checklistButtons[JCChecklistButtons.pass.rawValue].setTitleColor(.white, for: .normal)
        case .fail:
            self.checklistButtons[JCChecklistButtons.fail.rawValue].backgroundColor = UIColor(named: "Fail")
            self.checklistButtons[JCChecklistButtons.fail.rawValue].setTitleColor(.white, for: .normal)
        case .notAvailable:
            self.checklistButtons[JCChecklistButtons.notAvailable.rawValue].backgroundColor = UIColor(named: "NA")
            self.checklistButtons[JCChecklistButtons.notAvailable.rawValue].setTitleColor(.white, for: .normal)
        case .notApplicable:
            self.checklistButtons[JCChecklistButtons.notApplicable.rawValue].backgroundColor = UIColor(named: "NA")
            self.checklistButtons[JCChecklistButtons.notApplicable.rawValue].setTitleColor(.white, for: .normal)
        case .noSelection: setButtonsToNeutral()
        }
    }
}
