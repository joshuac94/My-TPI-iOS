//
//  JCBottomCell.swift
//  My TPI
//
//  Created by Joshua Colley on 30/04/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class JCBottomCell: UITableViewCell {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueField: JCTextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrapperView.layer.cornerRadius = 5.0
        wrapperView.layer.shadowRadius = 0.45
        wrapperView.layer.shadowColor = UIColor.lightGray.cgColor
        wrapperView.layer.shadowOpacity = 0.5
        wrapperView.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        
        valueField.setupTextField()
        clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(viewModel: JCApplianceRowViewModel) {
        self.titleLabel.text = viewModel.name
        self.valueField.text = viewModel.value
    }
    
}
