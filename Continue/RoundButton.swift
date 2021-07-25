//
//  RoundButton.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class RoundButton: UIButton {

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        self.setTitle("記録する", for: .normal)
        self.backgroundColor = UIColor.back
        self.layer.cornerRadius = 25
        self.addShadow()
    }

}
