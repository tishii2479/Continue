//
//  UIView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 4
    }
    
}
