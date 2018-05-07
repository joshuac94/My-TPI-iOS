//
//  JCApplianceListCell.swift
//  My TPI
//
//  Created by Joshua Colley on 15/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class JCApplianceListCell: UITableViewCell {
    
    @IBOutlet weak var progressIcon: UIImageView!
    @IBOutlet weak var assetNumber: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        assetNumber.sizeToFit()
        clientName.sizeToFit()
        
        wrapperView.layer.cornerRadius = 5.0
        wrapperView.layer.shadowRadius = 0.45
        wrapperView.layer.shadowColor = UIColor.lightGray.cgColor
        wrapperView.layer.shadowOpacity = 0.5
        wrapperView.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        
        self.tintColor = UIColor(named: "Primary")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIcon(outcome: String) {
        progressIcon.image = UIImage(named: outcome)
    }
    
}
