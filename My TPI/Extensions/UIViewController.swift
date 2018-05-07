//
//  JCBaseVC.swift
//  My TPI
//
//  Created by Joshua Colley on 15/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

enum JCElementTags: Int {
    case fab = 666
}

@objc protocol JCFloatingActionButtonDelegate {
    @objc func didClickFAB()
}

extension UIViewController {
    
    func setupFAB(icon: UIImage, delegate: JCFloatingActionButtonDelegate) {
        let fab = UIButton()
        fab.bounds = fab.frame
        fab.tag = JCElementTags.fab.rawValue
        fab.layer.cornerRadius = 33
        fab.layer.shadowColor = UIColor.gray.cgColor
        fab.backgroundColor = UIColor(named: "CTA")
        fab.setImage(icon, for: .normal)
        fab.layer.shadowRadius = 5
        fab.layer.shadowOffset = CGSize(width: 0, height: 2)
        fab.layer.shadowOpacity = 0.35
        fab.clipsToBounds = false
        fab.addTarget(self, action: #selector(delegate.didClickFAB), for: .touchUpInside)
        
        self.view.addSubview(fab)
        self.view.bringSubview(toFront: fab)
        
        fab.translatesAutoresizingMaskIntoConstraints = false
        fab.widthAnchor.constraint(equalToConstant: 66.0).isActive = true
        fab.heightAnchor.constraint(equalToConstant: 66.0).isActive = true
        fab.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        fab.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
    }
    
    func setupTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func fabFadeOut() {
        view.subviews.forEach { (subview) in
            if subview.tag == JCElementTags.fab.rawValue {
                UIView.animate(withDuration: 0.25, animations: {
                    if let fab = subview as? UIButton {
                        fab.alpha = 0.0
                    }
                })
            }
        }
    }
    
    func fabFadeIn() {
        view.subviews.forEach { (subview) in
            if subview.tag == JCElementTags.fab.rawValue {
                UIView.animate(withDuration: 0.25, animations: {
                    if let fab = subview as? UIButton {
                        fab.alpha = 1.0
                    }
                })
            }
        }
    }
    
    func fabIsVisible(_ bool: Bool) {
        view.subviews.forEach { (subview) in
            if subview.tag == JCElementTags.fab.rawValue {
                if let fab = subview as? UIButton {
                    if bool { fab.alpha = 1.0 }
                    else { fab.alpha = 0.0 }
                }
            }
        }
    }
    
}
