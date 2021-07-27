//
//  AddForm.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class AddForm: CardView {
    
    let titleLabel = TextLabel()
    let dateLabel = TextLabel()
    let datePicker = UIDatePicker()
    let dateField = UITextField()
    let recordLabel = TextLabel()
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        
        dateLabel.text = "日付"
        
        dateField.backgroundColor = UIColor.lightGray
        dateField.layer.cornerRadius = 10
        dateField.textAlignment = .center
        dateField.textColor = UIColor.text
        dateField.text = Date().toString(format: "yyyy/MM/dd E")
        
        recordLabel.text = "記録"
        
        recordField.backgroundColor = UIColor.lightGray
        recordField.layer.cornerRadius = 10
        recordField.textAlignment = .center
        recordField.textColor = UIColor.text
        recordField.font = UIFont.systemFont(ofSize: 28)
        recordField.keyboardType = .numberPad

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dateField)
        stackView.addArrangedSubview(recordLabel)
        stackView.addArrangedSubview(recordField)

        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        datePicker.addTarget(self, action: #selector(changeDateValue), for: .valueChanged)
        dateField.inputView = datePicker

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(changeDateValue))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            dateField.widthAnchor.constraint(equalToConstant: 200),
            dateField.heightAnchor.constraint(equalToConstant: 40),
            recordField.widthAnchor.constraint(equalToConstant: 200),
            recordField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addData() -> String? {
        let record: Int32? = Int32(recordField.text!)
        guard let _record = record else {
            return "PARSE_ERROR"
        }
        
        RecordData.addData(date: datePicker.date, record: _record)
    
        return nil
    }
    
    @objc func changeDateValue() {
        dateField.endEditing(true)
        
        dateField.text = datePicker.date.toString(format: "yyyy/MM/dd E")
    }

}
