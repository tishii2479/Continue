//
//  BoardViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit
import CoreData

class BoardViewController: ViewController, DataProtocol {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let recordModal = RecordModal()
    let chartView = ChartView()
    let tableView = TableView()
    let addButton = RoundButton(title: "記録する")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.recordModal.delegate = self
        self.tableView.delegate = self
        
        self.sideMenu.delegate = self
        
        self.checkFirstLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.reloadData()
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        self.titleField.textAlignment = .center
        self.titleField.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleField.addTarget(self, action: #selector(startEditingTitleField(_:)), for: .editingDidBegin)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditingTitleField(_:)))
        doneItem.tintColor = UIColor.pink
        toolbar.setItems([spaceItem, doneItem], animated: true)

        self.titleField.inputAccessoryView = toolbar
        self.navigationItem.titleView = titleField
        
        self.setNavigationTitleText(title: RecordData.currentHabitName)
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonClicked(_:)))
        deleteButton.tintColor = UIColor.pink
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    override func setLayout() {
        super.setLayout()
        
        self.scrollView.frame = self.view.bounds
        self.scrollView.showsVerticalScrollIndicator = false

        self.view.addSubview(self.scrollView)
        
        self.addButton.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        
        self.stackView.addArrangedSubview(chartView)
        self.stackView.addArrangedSubview(addButton)
        self.stackView.addArrangedSubview(tableView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .fill
        self.stackView.spacing = 20
        
        self.scrollView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            // constraints for scrollView
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            // constraints for stackView
            self.stackView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20),
            self.stackView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -20),
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -20),
            self.stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40),
            self.stackView.heightAnchor.constraint(equalToConstant: 800),
            // constraints for cards
            self.chartView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor, constant: 0),
            self.chartView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 0),
            self.chartView.heightAnchor.constraint(equalToConstant: 200),
            self.addButton.heightAnchor.constraint(equalToConstant: 50),
            self.addButton.widthAnchor.constraint(equalToConstant: 200),
            self.tableView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor, constant: 0),
            self.tableView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 0),
        ])
        
        self.navigationController?.view.addSubview(recordModal)
    }
    
    func reloadData() {
        print("[debug] reload data")
        self.tableView.reloadData()
        self.chartView.reloadData()
        self.sideMenu.reloadData()
        
        self.setNavigationBar()
    }
    
    func openModal(data: RecordData?) {
        self.recordModal.fadeIn(data: data)
    }
    
    func deleteAlert(data: RecordData) {
        let message = data.date!.toString(format: "yyyy/MM/dd") + "のデータを削除しますか？"
        let alert = UIAlertController(title: "データの削除", message: message, preferredStyle: UIAlertController.Style.alert)

        let deleteAction = UIAlertAction(title: "削除する", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            
            RecordData.deleteData(data: data)
            self.reloadData()
        })

        let closeAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        })

        alert.addAction(deleteAction)
        alert.addAction(closeAction)

        self.present(alert, animated: true, completion: nil)
    }

    func openNewHabit(isFirstLoad: Bool) {
        let animated = !isFirstLoad
        let habitVC = CreateHabitViewController(isFirstLoad: isFirstLoad)
        habitVC.modalPresentationStyle = .fullScreen
        self.present(habitVC, animated: animated, completion: nil)
    }
    
    private func checkFirstLoad() {
        if RecordData.currentHabitId == nil {
            openNewHabit(isFirstLoad: true)
        }
    }
    
    @objc func endEditingTitleField(_ sender: UIBarButtonItem) {
        // TODO: check nil
        
        self.titleField.endEditing(true)
        self.switchMask(isOn: false)
    }
    
    @objc func startEditingTitleField(_ sender: UITextField) {
        self.switchMask(isOn: true)
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        self.recordModal.fadeIn(data: nil)
    }
    
    @objc func deleteButtonClicked(_ sender: UIBarButtonItem) {
        guard let habitName = RecordData.currentHabitName else {
            print("ERROR")
            return
        }
        
        let title = habitName + "のデータを削除しますか？"
        let message = "一度削除するとデータは元に戻りません"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let deleteAction = UIAlertAction(title: "削除する", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            Habit.deleteData(data: Habit.currentHabit)
            
            self.reloadData()
        })

        let closeAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        })

        alert.addAction(deleteAction)
        alert.addAction(closeAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}
