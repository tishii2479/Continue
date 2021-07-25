//
//  ChartView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/24.
//

import UIKit

class ChartView: CardView {

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        let text = UILabel()
        text.text = "Hello world!"
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.leftAnchor.constraint(equalTo: self.leftAnchor),
            text.widthAnchor.constraint(equalToConstant: 200),
            text.topAnchor.constraint(equalTo: self.topAnchor),
            text.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
