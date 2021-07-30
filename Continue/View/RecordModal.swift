//
//  RecordModal.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class RecordModal: UIView {
    
    weak var delegate: DataProtocol?
    private var editingData: RecordData?
    private let recordForm = RecordForm()
    private let addButton = RoundButton(title: "記録する")
    private let closeButton = IconButton(systemName: "multiply", cornerRadius: 15)
    private let blackMask = UIView()

    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.blackMask.frame = CGRect(x: 0, y: -self.bounds.height, width: self.bounds.width, height: self.bounds.height * 2)
        self.blackMask.backgroundColor = UIColor.clear
        
        self.addSubview(self.blackMask)
        
        self.addSubview(self.closeButton)
        self.addSubview(self.recordForm)
        self.addSubview(self.addButton)
        
        self.closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            self.closeButton.widthAnchor.constraint(equalToConstant: 30),
            self.closeButton.heightAnchor.constraint(equalToConstant: 30),
            self.recordForm.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.recordForm.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.recordForm.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 20),
            self.recordForm.heightAnchor.constraint(equalToConstant: 200),
            self.addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            self.addButton.topAnchor.constraint(equalTo: self.recordForm.bottomAnchor, constant: 20),
            self.addButton.heightAnchor.constraint(equalToConstant: 50),
            self.addButton.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        // set side menu out of the screen
        self.center.y = UIScreen.main.bounds.height * 3 / 2
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeButtonClicked(_:)))
        swipeGesture.direction = .down
        self.recordForm.addGestureRecognizer(swipeGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func closeButtonClicked(_ sender: UIButton) {
        self.fadeOut()
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        if self.editingData != nil {
            RecordData.deleteData(data: self.editingData!)
        }
        
        if let error = recordForm.addData() {
            showError(error: error)
            return
        }
        
        self.delegate?.reloadData()
        self.fadeOut()
    }
    
    func fadeIn(data: RecordData?) {
        self.recordForm.clearField()
        self.editingData = nil
        
        if let _data = data {
            self.editingData = _data
            self.recordForm.setField(data: _data)
        }
        
        self.recordForm.focusRecordField()
        
        // fade in side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.y = UIScreen.main.bounds.height / 2
            self.blackMask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    
    func fadeOut() {
        self.endEditing(true)
        
        // fade out side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.y = UIScreen.main.bounds.height * 3 / 2
            self.blackMask.backgroundColor = UIColor.clear
        })
    }
    
    private func showError(error: String) {
        print(error)
    }
    
}
