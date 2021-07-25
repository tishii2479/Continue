//
//  BoardViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class BoardViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
    }
    
    override func setLayout() {
        super.setLayout()
        
        let scrollView = UIScrollView(frame: self.view.bounds)

        self.view.addSubview(scrollView)
        
        let chartView = ChartView()
        let tableView = TableView()
        let addButton = RoundButton()
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [chartView, addButton, tableView])
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
        
    }
    
    @objc func addButtonClicked(_ sender:UIButton) {
        print("ボタンが押されたよ")
    }

}
