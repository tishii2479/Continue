//
//  AddModal.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class AddModal: UIView {
    
    let addForm = AddForm()
    let addButton = RoundButton()
    let closeButton = RoundButton()
    private var isSeen: Bool = false

    init() {
        super.init(frame: UIScreen.main.bounds)
        
        let mask = UIView(frame: UIScreen.main.bounds)
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        self.addSubview(mask)
        
        self.addSubview(closeButton)
        self.addSubview(addForm)
        self.addSubview(addButton)
        
        closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            addForm.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            addForm.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            addForm.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
            addForm.heightAnchor.constraint(equalToConstant: 250),
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            addButton.topAnchor.constraint(equalTo: addForm.bottomAnchor, constant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        // set side menu out of the screen
        self.center.y += UIScreen.main.bounds.height
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        fadeOut()
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        print("add")
        let record = addForm.getData()
        print(record)
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
