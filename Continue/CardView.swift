//
//  CardView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class CardView: UIView {

    init(size: CGSize) {
        super.init(frame: CGRect(origin: CGPoint.zero, size: size))
        
        self.backgroundColor = UIColor.back
        self.layer.cornerRadius = 20
        
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
