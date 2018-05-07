//
//  JCExpandableHeaderView.swift
//  My TPI
//
//  Created by Joshua Colley on 14/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

protocol JCExpandableHeaderViewDelegate {
    func toggleSection(header: JCExpandableHeaderView, section: Int)
}

class JCExpandableHeaderView: UITableViewHeaderFooterView {

    let toggleIcon: UIImageView = UIImageView()
    
    var delegate: JCExpandableHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesture: UITapGestureRecognizer) {
        guard let cell = gesture.view as? JCExpandableHeaderView else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: JCExpandableHeaderViewDelegate) {
        
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
        
        toggleIcon.image = #imageLiteral(resourceName: "chevron-arrow")
        toggleIcon.tintColor = UIColor.gray
        toggleIcon.contentMode = .scaleAspectFit
        
        self.addSubview(toggleIcon)
        
        toggleIcon.translatesAutoresizingMaskIntoConstraints = false
        toggleIcon.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
        toggleIcon.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        toggleIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0).isActive = true
        toggleIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        line.backgroundColor = UIColor.darkGray
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        line.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0).isActive = true
        line.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor(named: "Primary")!
        self.contentView.backgroundColor = .white
    }
    
    func animateChevron(isActive: Bool) {
        UIView.animate(withDuration: 0.45) {
            if isActive {
                self.toggleIcon.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi * 0.999))
            } else {
                self.toggleIcon.transform = .identity
            }
        }
    }

}
