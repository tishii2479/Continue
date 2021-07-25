//
//  AddModal.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class AddModal: UIView {
    
    private var isSeen: Bool = false

    init() {
        super.init(frame: UIScreen.main.bounds)
        let mask = UIView(frame: UIScreen.main.bounds)
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fadeOut(_:)))
        mask.addGestureRecognizer(tapGesture)
        
        self.addSubview(mask)
        
        // set side menu out of the screen
        self.center.y += UIScreen.main.bounds.height
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func fadeOut(_ sender: UITapGestureRecognizer) {
        // fade out side menu
        fadeOut()
    }
    
    func fadeIn() {
        if isSeen { return }
        
        isSeen = true
        
        // fade in side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.y -= UIScreen.main.bounds.height
        })
    }
    
    func fadeOut() {
        if isSeen == false { return }
        
        isSeen = false
        
        // fade out side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.y += UIScreen.main.bounds.height
        })
    }
}
