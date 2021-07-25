//
//  AddForm.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class AddForm: CardView {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let dateField = UITextField()
    let recordLabel = UILabel()
    let recordField = UITextField()

    override init() {
        super.init()
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        self.addSubview(stackView)
        
        titleLabel.text = "記録する"
        dateLabel.text = "日付"
        
        dateField.backgroundColor = UIColor.white
        
        recordLabel.text = "記録"
        
        recordField.backgroundColor = UIColor.white

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dateField)
        stackView.addArrangedSubview(recordLabel)
        stackView.addArrangedSubview(recordField)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            dateField.widthAnchor.constraint(equalToConstant: 100),
            dateField.heightAnchor.constraint(equalToConstant: 30),
            recordField.widthAnchor.constraint(equalToConstant: 100),
            recordField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getData() -> Record<Int> {
        return Record<Int>(date: Date(), record: 100)
    }

}
