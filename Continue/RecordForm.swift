//
//  RecordForm.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class RecordForm: CardView {
    
    let stackView = UIStackView()
    let titleLabel = TextLabel()
    let dateLabel = TextLabel()
    let datePicker = UIDatePicker()
    let dateField = UITextField()
    let recordLabel = TextLabel()
    let recordField = UITextField()

    override init() {
        super.init()
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        
        self.addSubview(stackView)
        
        self.titleLabel.text = "記録する"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        
        self.dateLabel.text = "日付"
        
        self.dateField.backgroundColor = UIColor.lightGray
        self.dateField.layer.cornerRadius = 10
        self.dateField.textAlignment = .center
        self.dateField.textColor = UIColor.text
        self.dateField.text = Date().toString(format: "yyyy/MM/dd E")
        
        self.recordLabel.text = "記録"
        
        self.recordField.backgroundColor = UIColor.lightGray
        self.recordField.layer.cornerRadius = 10
        self.recordField.textAlignment = .center
        self.recordField.textColor = UIColor.text
        self.recordField.font = UIFont.systemFont(ofSize: 28)
        self.recordField.keyboardType = .numberPad

        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(dateLabel)
        self.stackView.addArrangedSubview(dateField)
        self.stackView.addArrangedSubview(recordLabel)
        self.stackView.addArrangedSubview(recordField)
        
        self.datePicker.datePickerMode = .date
        self.datePicker.locale = .current
        if #available(iOS 14, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.sizeToFit()
        }
        
        self.datePicker.timeZone = NSTimeZone.local
        self.datePicker.locale = Locale.current
        self.datePicker.addTarget(self, action: #selector(changeDateValue), for: .valueChanged)
        self.dateField.inputView = datePicker

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        self.dateField.inputAccessoryView = toolbar
        self.recordField.inputAccessoryView = toolbar
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.dateField.widthAnchor.constraint(equalToConstant: 200),
            self.dateField.heightAnchor.constraint(equalToConstant: 40),
            self.recordField.widthAnchor.constraint(equalToConstant: 200),
            self.recordField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func focusRecordField() {
        self.recordField.becomeFirstResponder()
    }
    
    func addData() -> String? {
        let record: Int32? = Int32(recordField.text!)
        guard let _record = record else {
            return "PARSE_ERROR"
        }
        
        RecordData.addData(date: datePicker.date, record: _record)
    
        return nil
    }
    
    func clearField() {
        self.recordField.text = ""
        self.dateField.text = Date().toString(format: "yyyy/MM/dd E")
    }
    
    func setField(data: RecordData) {
        self.recordField.text = String(data.record)
        self.dateField.text = data.date?.toString(format: "yyyy/MM/dd E")
        self.datePicker.date = data.date!
    }
    
    @objc func changeDateValue() {
        dateField.text = datePicker.date.toString(format: "yyyy/MM/dd E")
    }

}
