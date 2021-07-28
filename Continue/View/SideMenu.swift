//
//  SideMenu.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class MenuContent: UIView {
    
    weak var delegate: HabitProtocol?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 250, height: UIScreen.main.bounds.height))
        
        self.backgroundColor = UIColor.back
        self.addShadow()
        
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        stackView.spacing = 30
        
        self.addSubview(stackView)
        
        let titleLabel = TextLabel()
        titleLabel.text = "一覧"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        stackView.addArrangedSubview(titleLabel)
        
        let habits = Habit.getArray()
        
        for habit in habits {
            let label = TextLabel()
            label.text = habit.name
            stackView.addArrangedSubview(label)
        }
        
        let spacing = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        spacing.backgroundColor = UIColor.clear
        stackView.addArrangedSubview(spacing)
        
        let newButton = UIButton()
        newButton.setTitle("新規作成", for: .normal)
        newButton.setTitleColor(UIColor.pink, for: .normal)
        newButton.addTarget(self, action: #selector(newButtonTapped(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(newButton)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func newButtonTapped(_ sender: UIButton) {
        self.delegate?.openNewHabit()
    }
    
}

class SideMenu: UIView {
    
    var delegate: HabitProtocol? {
        set {
            self.menu.delegate = newValue
        }
        get {
            return nil
        }
    }
    
    let blackMask = UIView()
    let menu = MenuContent()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.addShadow()
        
        self.blackMask.frame = CGRect(x: 0, y: 0, width: self.bounds.width * 2, height: self.bounds.height)
        self.blackMask.backgroundColor = UIColor.clear
        
        self.addSubview(blackMask)
        self.addSubview(menu)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fadeOut(_:)))
        self.blackMask.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(fadeOut(_:)))
        swipeGesture.direction = .left
        self.addGestureRecognizer(swipeGesture)
        
        // set side menu out of the screen
        self.center.x = -UIScreen.main.bounds.width / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func fadeOut(_ sender: UITapGestureRecognizer) {
        // fade out side menu
        fadeOut()
    }
    
    func fadeIn() {
        // fade in side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.x = UIScreen.main.bounds.width / 2
            self.blackMask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    
    func fadeOut() {
        // fade out side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.x = -UIScreen.main.bounds.width / 2
            self.blackMask.backgroundColor = UIColor.clear
        })
    }
    
}
