//
//  CustomView.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 7/24/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import Foundation
import UIKit
class CustomView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6) .cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        clipsToBounds = true
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6) .cgColor
    }
    
}
