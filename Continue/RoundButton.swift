//
//  RoundButton.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class RoundButton: UIButton {

    init(title: String? = nil, cornerRadius: CGFloat = 25) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let _title = title {
            self.setTitle(_title, for: .normal)
            self.setTitleColor(UIColor.pink, for: .normal)
        }
        
        self.backgroundColor = UIColor.back
        self.layer.cornerRadius = cornerRadius
        self.addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
