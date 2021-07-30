//
//  RecordForm.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class RecordForm: CardView {
    
    private let stackView = UIStackView()
    private let titleLabel = TextLabel()
    private let dateImage = UIImageView()
    private let datePicker = UIDatePicker()
    private let dateField = UITextField()
    private let recordImage = UIImageView()
    private let recordField = UITextField()

    override init() {
        super.init()
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        
        self.addSubview(stackView)
        
        self.titleLabel.text = "記録する"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        
        self.dateImage.image = UIImage(systemName: "calendar.circle")?.withRenderingMode(.alwaysTemplate)
        self.dateImage.tintColor = UIColor.pink
        self.dateImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateField.backgroundColor = UIColor.lightGray
        self.dateField.layer.cornerRadius = 10
        self.dateField.textAlignment = .center
        self.dateField.textColor = UIColor.text
        self.dateField.text = Date().toString(format: "yyyy/MM/dd E")
        
        self.recordImage.image = UIImage(systemName: "pencil.circle")?.withRenderingMode(.alwaysTemplate)
        self.recordImage.tintColor = UIColor.pink
        self.recordImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.recordField.backgroundColor = UIColor.lightGray
        self.recordField.layer.cornerRadius = 10
        self.recordField.textAlignment = .center
        self.recordField.textColor = UIColor.text
        self.recordField.font = UIFont.systemFont(ofSize: 28)
        self.recordField.keyboardType = .numberPad

        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(dateField)
        self.stackView.addArrangedSubview(recordField)
        
        self.addSubview(dateImage)
        self.addSubview(recordImage)
        
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

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        doneItem.tintColor = UIColor.pink
        toolbar.setItems([spaceItem, doneItem], animated: true)

        self.dateField.inputAccessoryView = toolbar
        self.recordField.inputAccessoryView = toolbar
        
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.dateField.widthAnchor.constraint(equalToConstant: 200),
            self.dateField.heightAnchor.constraint(equalToConstant: 40),
            self.dateImage.leftAnchor.constraint(equalTo: self.dateField.leftAnchor, constant: 10),
            self.dateImage.centerYAnchor.constraint(equalTo: self.dateField.centerYAnchor),
            self.dateImage.widthAnchor.constraint(equalToConstant: 20),
            self.dateImage.heightAnchor.constraint(equalToConstant: 20),
            self.recordField.widthAnchor.constraint(equalToConstant: 200),
            self.recordField.heightAnchor.constraint(equalToConstant: 60),
            self.recordImage.leftAnchor.constraint(equalTo: self.recordField.leftAnchor, constant: 10),
            self.recordImage.centerYAnchor.constraint(equalTo: self.recordField.centerYAnchor),
            self.recordImage.widthAnchor.constraint(equalToConstant: 20),
            self.recordImage.heightAnchor.constraint(equalToConstant: 20),
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
        
        RecordData.addData(date: Calendar.current.startOfDay(for: datePicker.date), record: _record)
    
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
        self.dateField.text = self.datePicker.date.toString(format: "yyyy/MM/dd E")
    }

}
