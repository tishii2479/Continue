//
//  CreateHabitViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/28.
//

import UIKit

class CreateHabitViewController: ViewController {

    let stackView = UIStackView()
    let habitForm = HabitForm()
    let addButton = RoundButton(title: "はじめる")
    let closeButton = IconButton(systemName: "multiply", cornerRadius: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayout() {
        super.setLayout()
        
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(habitForm)
        self.stackView.addArrangedSubview(addButton)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        
        self.closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(addNewHabit(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            self.closeButton.widthAnchor.constraint(equalToConstant: 30),
            self.closeButton.heightAnchor.constraint(equalToConstant: 30),
            // constraints for stackView
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40),
            self.stackView.heightAnchor.constraint(equalToConstant: 230),
            // constraints for cards
            self.habitForm.leftAnchor.constraint(equalTo: self.stackView.leftAnchor, constant: 0),
            self.habitForm.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 0),
            self.habitForm.heightAnchor.constraint(equalToConstant: 140),
            self.addButton.heightAnchor.constraint(equalToConstant: 50),
            self.addButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc func addNewHabit(_ sender: UIButton) {
        let name = self.habitForm.getInput()
        guard let _name = name else {
            // TODO:
            // tell user an error
            print("NO_INPUT")
            return
        }
        
        Habit.addData(habitName: _name)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
