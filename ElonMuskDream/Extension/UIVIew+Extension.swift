//
//  UIVIew+Extension.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/9/22.
//

import UIKit

extension UIView {
    func shadowConfig(_ shadowColor: CGColor? = UIColor(named: "shadow")?.cgColor , _ shadowRadius: CGFloat? = 1, _ shadowOpacity: Float? = 1, _ shadowOffset: CGSize? = CGSize(width: 1, height: 2) ) {
        //self.layer.shouldRasterize = true
        //self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowColor = shadowColor
        self.layer.shadowRadius = shadowRadius!
        self.layer.shadowOpacity = shadowOpacity!
        self.layer.shadowOffset = shadowOffset!
    }
    
    func addCornerRadius(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
}
