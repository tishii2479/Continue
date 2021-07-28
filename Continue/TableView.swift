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
    let editButton = IconButton(systemName: "pencil")
    let deleteButton = IconButton(systemName: "lasso")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        // ISSUE:
        // using ad-hoc solution to fit the size of the cell
        self.stackView.frame = CGRect(x: 0, y: 0, width: self.bounds.width - 50, height: self.bounds.height)
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.distribution = .fill
        self.stackView.spacing = 20
        
        self.dateText.font = UIFont.systemFont(ofSize: 12)
        self.recordText.font = UIFont.systemFont(ofSize: 14)
        
        self.recordText.textAlignment = .right
        
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.dateText)
        self.stackView.addArrangedSubview(self.recordText)
        self.stackView.addArrangedSubview(self.editButton)
        self.stackView.addArrangedSubview(self.deleteButton)
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor.lightGray
        seperator.frame = CGRect(x: 0, y: self.contentView.frame.size.height - 2.0,  width: self.contentView.frame.size.width, height: 2.0)
        self.contentView.addSubview(seperator)
        
        NSLayoutConstraint.activate([
            self.dateText.widthAnchor.constraint(equalToConstant: 80),
            self.editButton.widthAnchor.constraint(equalToConstant: 20),
            self.deleteButton.widthAnchor.constraint(equalToConstant: 20),
            self.deleteButton.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(data: RecordData) {
        dateText.text = data.date?.toString(format: "M/d E")
        recordText.text = "\(data.record)回"
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
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func reloadData() {
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
