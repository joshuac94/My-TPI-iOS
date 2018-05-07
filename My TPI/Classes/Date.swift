//
//  Date.swift
//  My TPI
//
//  Created by Joshua Colley on 12/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

extension Date {
    
    func displayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
