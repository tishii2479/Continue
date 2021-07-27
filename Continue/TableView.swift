//
//  TableView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/24.
//

import UIKit

class TableCell: UITableViewCell {
    
    let stackView = UIStackView()
    let dateText = TextLabel()
    let recordText = TextLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        self.stackView.frame = self.bounds
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.dateText)
        self.stackView.addArrangedSubview(self.recordText)
        
        NSLayoutConstraint.activate([
            self.dateText.widthAnchor.constraint(equalToConstant: 100),
            self.recordText.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(data: RecordData) {
        dateText.text = data.date?.toString(format: "MM/dd E")
        recordText.text = String(data.record)
    }
    
}

class TableView: CardView {
    
    let tableView = UITableView()
    var records: [RecordData]!

    override init() {
        super.init()
        
        records = RecordData.getArray()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.back
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func reloadTable() {
        records = RecordData.getArray()
        tableView.reloadData()
    }
    
}

extension TableView: UITableViewDelegate {
    
}

extension TableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableCell(style: .default, reuseIdentifier: "cell")
        cell.setup(data: records[indexPath.row])
        
        return cell
    }
    
}
