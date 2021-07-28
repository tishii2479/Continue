//
//  RecordModal.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class RecordModal: UIView {
    
    weak var delegate: DataProtocol?
    let recordForm = RecordForm()
    let addButton = RoundButton(title: "記録する")
    let closeButton = RoundButton()

    init() {
        super.init(frame: UIScreen.main.bounds)
        
        let mask = UIView(frame: UIScreen.main.bounds)
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        self.addSubview(mask)
        
        self.addSubview(closeButton)
        self.addSubview(recordForm)
        self.addSubview(addButton)
        
        self.closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.closeButton.widthAnchor.constraint(equalToConstant: 50),
            self.closeButton.heightAnchor.constraint(equalToConstant: 50),
            self.recordForm.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.recordForm.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.recordForm.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 20),
            self.recordForm.heightAnchor.constraint(equalToConstant: 250),
            self.addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            self.addButton.topAnchor.constraint(equalTo: self.recordForm.bottomAnchor, constant: 30),
            self.addButton.heightAnchor.constraint(equalToConstant: 50),
            self.addButton.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        // set side menu out of the screen
        self.center.y = UIScreen.main.bounds.height * 3 / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        self.fadeOut()
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        if let error = recordForm.addData() {
            showError(error: error)
            return
        }
        
        self.delegate?.reloadData()
        self.fadeOut()
    }
    
    func fadeIn(data: RecordData?) {
        self.recordForm.clearField()
        
        if let _data = data {
            self.recordForm.setField(data: _data)
        }
        
        self.recordForm.focusRecordField()
        
        // fade in side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.y = UIScreen.main.bounds.height / 2
        })
    }
    
    func fadeOut() {
        self.endEditing(true)
        
        // fade out side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.y = UIScreen.main.bounds.height * 3 / 2
        })
    }
    
    private func showError(error: String) {
        print(error)
    }
    
}
