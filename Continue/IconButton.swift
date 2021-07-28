//
//  IconButton.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/27.
//

import UIKit

class IconButton: UIButton {

    init(systemName: String, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.back
        self.layer.cornerRadius = cornerRadius
        self.addShadow()
        
        self.setImage(UIImage(systemName: systemName), for: .normal)
        self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        self.tintColor = UIColor.pink
    
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
