//
//  CustomSV.swift
//  MyWearherApp
//
//  Created by D N on 26/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import UIKit

class CustomSV: UIScrollView {
    
    
    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.refreshControl = UIRefreshControl()
        
        
    }
    
}
