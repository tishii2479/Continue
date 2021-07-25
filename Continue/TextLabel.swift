//
//  TextLabel.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class TextLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textColor = UIColor.text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
