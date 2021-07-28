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
    lazy var addModal = AddModal(controller: self)
    let chartView = ChartView()
    let tableView = TableView()
    let addButton = RoundButton(title: "記録する")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        let menuButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearTable(_:)))
        self.navigationItem.rightBarButtonItem = menuButton
    }
    
    override func setLayout() {
        super.setLayout()
        
        scrollView.frame = self.view.bounds
        scrollView.showsVerticalScrollIndicator = false

        self.view.addSubview(scrollView)
        
        addButton.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(chartView)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(tableView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // constraints for scrollView
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            // constraints for stackView
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40),
            stackView.heightAnchor.constraint(equalToConstant: 800),
            // constraints for cards
            chartView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            chartView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            chartView.heightAnchor.constraint(equalToConstant: 200),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 200),
            tableView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
        ])
        
        self.navigationController?.view.addSubview(addModal)
    }
    
    @objc func addButtonClicked(_ sender: UIButton) {
        addModal.fadeIn()
    }
    
    @objc func clearTable(_ sender: UIBarButtonItem) {
        RecordData.clearArray()
        reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
        chartView.reloadData()
    }

}
