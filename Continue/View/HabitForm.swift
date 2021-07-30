//
//  HabitForm.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/28.
//

import UIKit

class HabitForm: CardView {
    
    let stackView = UIStackView()
    let titleLabel = TextLabel()
    let nameImage = UIImageView()
    let nameField = UITextField()

    override init() {
        super.init()
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        
        self.addSubview(stackView)
        
        self.titleLabel.text = "新しい習慣"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        
        self.nameImage.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        self.nameImage.tintColor = UIColor.pink
        self.nameImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameField.backgroundColor = UIColor.lightGray
        self.nameField.layer.cornerRadius = 10
        self.nameField.textAlignment = .center
        self.nameField.textColor = UIColor.text
        self.nameField.text = ""
    
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(nameField)
        
        self.addSubview(nameImage)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        doneItem.tintColor = UIColor.pink
        toolbar.setItems([spaceItem, doneItem], animated: true)

        self.nameField.inputAccessoryView = toolbar
        
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.nameField.widthAnchor.constraint(equalToConstant: 250),
            self.nameField.heightAnchor.constraint(equalToConstant: 40),
            self.nameImage.leftAnchor.constraint(equalTo: self.nameField.leftAnchor, constant: 10),
            self.nameImage.centerYAnchor.constraint(equalTo: self.nameField.centerYAnchor),
            self.nameImage.widthAnchor.constraint(equalToConstant: 20),
            self.nameImage.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func focusNameField() {
        self.nameField.becomeFirstResponder()
    }
    
    func clearField() {
        self.nameField.text = ""
    }
    
    func getInput() -> String? {
        return self.nameField.text
    }

}
