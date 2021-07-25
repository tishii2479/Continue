//
//  TableView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/24.
//

import UIKit

class TableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        self.addSubview(stackView)
        
        let dateText = UILabel()
        dateText.text = "2021/07/12"
        let recordText = UILabel()
        recordText.text = "101回"
        
        stackView.addArrangedSubview(dateText)
        stackView.addArrangedSubview(recordText)
    }
    
}

class TableView: CardView {

    override init() {
        super.init()
    }
    
    override func layoutSubviews() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.back
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TableView: UITableViewDelegate {
    
}

extension TableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = String(indexPath.hashValue)
        
        return cell
    }
    
}
