//
//  CreateHabitViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/28.
//

import UIKit

class CreateHabitViewController: ViewController {

    private var isFirstLoad: Bool = false
    private let stackView = UIStackView()
    private let habitForm = HabitForm()
    private let addButton = RoundButton(title: "はじめる")
    private let closeButton = IconButton(systemName: "multiply", cornerRadius: 15)
    
    init(isFirstLoad: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isFirstLoad = isFirstLoad
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.habitForm.focusNameField()
    }
    
    override func setLayout() {
        super.setLayout()
        
        if isFirstLoad == false {
            self.view.addSubview(self.closeButton)
            NSLayoutConstraint.activate([
                self.closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
                self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                self.closeButton.widthAnchor.constraint(equalToConstant: 30),
                self.closeButton.heightAnchor.constraint(equalToConstant: 30),
            ])
        }
        
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
            // constraints for stackView
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
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
        
        // TODO: show error
        if name == "" { return }
        
        Habit.addData(habitName: name)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
