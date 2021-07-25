//
//  CardView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class CardView: UIView {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .back
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false

        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
