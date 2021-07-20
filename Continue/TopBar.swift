//
//  TopBar.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class TopBar: UIView {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        self.backgroundColor = UIColor.back
        
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
