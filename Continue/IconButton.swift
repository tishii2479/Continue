//
//  IconButton.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/27.
//

import UIKit

class IconButton: UIButton {

    init(systemName: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setImage(UIImage(systemName: systemName), for: .normal)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
