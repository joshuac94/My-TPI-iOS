//
//  JCSplashVC.swift
//  My TPI
//
//  Created by Joshua Colley on 27/04/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import Lottie

class JCSplashVC: UIViewController {
    
    @IBOutlet weak var craneAnimationWrapper: UIView!
    @IBOutlet weak var noticeTextView: UITextView!
    @IBOutlet weak var loadingAnimationWrapper: UIView!
    
    var craneView: LOTAnimationView!
    var loadingView: LOTAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        craneView = LOTAnimationView(name: "construction_site")
        craneView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                 size: CGSize(width: craneAnimationWrapper.frame.width,
                                              height: craneAnimationWrapper.frame.height))
        craneAnimationWrapper.addSubview(craneView)
        
        loadingView = LOTAnimationView(name: "pulse_loader")
        loadingView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                 size: CGSize(width: loadingAnimationWrapper.frame.width,
                                              height: loadingAnimationWrapper.frame.height))
        loadingView.loopAnimation = true
        loadingAnimationWrapper.addSubview(loadingView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        craneView.play()
        loadingView.play()
    }
}
