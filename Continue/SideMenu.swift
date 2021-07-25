//
//  SideMenu.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class MenuContent: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 250, height: UIScreen.main.bounds.height))
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.back
        self.addShadow()
        
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        self.addSubview(stackView)
        
        let titleLabel = TextLabel()
        titleLabel.text = "一覧"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        stackView.addArrangedSubview(titleLabel)
        
        for _ in 0 ..< 4 {
            let label = TextLabel()
            label.text = "ランニング"
            stackView.addArrangedSubview(label)
        }
        
        let spacing = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        spacing.backgroundColor = UIColor.clear
        stackView.addArrangedSubview(spacing)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class SideMenu: UIView {
    
    private var isSeen: Bool = false

    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.addShadow()
        
        let mask = UIView(frame: UIScreen.main.bounds)
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        let menu = MenuContent()
        
        self.addSubview(mask)
        self.addSubview(menu)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fadeOut(_:)))
        mask.addGestureRecognizer(tapGesture)
        
        // set side menu out of the screen
        self.center.x -= UIScreen.main.bounds.width
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
            self.center.x += UIScreen.main.bounds.width
        })
    }
    
    func fadeOut() {
        if isSeen == false { return }
        
        isSeen = false
        
        // fade out side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.x -= UIScreen.main.bounds.width
        })
    }
}
