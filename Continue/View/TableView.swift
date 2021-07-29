//
//  TableView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/24.
//

import UIKit

class TableCell: UITableViewCell {
    
    weak var delegate: DataProtocol?
    let stackView = UIStackView()
    let dateText = TextLabel()
    let recordText = TextLabel()
    let badgeImage = UIImageView()
    let editButton = IconButton(systemName: "pencil", cornerRadius: 15)
    let deleteButton = IconButton(systemName: "multiply", cornerRadius: 15)
    
    var data: RecordData?
    
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
        self.stackView.spacing = 10
        
        self.dateText.font = UIFont.systemFont(ofSize: 12)
        self.recordText.font = UIFont.systemFont(ofSize: 14)
        
        self.recordText.textAlignment = .right
        
        self.editButton.addTarget(self, action: #selector(editTapped(_:)), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.dateText)
        self.stackView.addArrangedSubview(self.recordText)
        self.stackView.addArrangedSubview(self.badgeImage)
        self.stackView.addArrangedSubview(self.editButton)
        self.stackView.addArrangedSubview(self.deleteButton)
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor.lightGray
        seperator.frame = CGRect(x: 0, y: self.contentView.frame.size.height - 2.0,  width: self.contentView.frame.size.width, height: 2.0)
        self.contentView.addSubview(seperator)
        
        NSLayoutConstraint.activate([
            self.dateText.widthAnchor.constraint(equalToConstant: 70),
            self.badgeImage.widthAnchor.constraint(equalToConstant: 20),
            self.badgeImage.heightAnchor.constraint(equalToConstant: 20),
            self.editButton.widthAnchor.constraint(equalToConstant: 30),
            self.editButton.heightAnchor.constraint(equalToConstant: 30),
            self.deleteButton.widthAnchor.constraint(equalToConstant: 30),
            self.deleteButton.heightAnchor.constraint(equalToConstant: 30),
            self.deleteButton.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(data: RecordData, delta: Int, delegate: DataProtocol?) {
        self.delegate = delegate
        self.data = data
        
        self.dateText.text = data.date?.toString(format: "M/d E")
        self.recordText.text = "\(data.record)回"
        
        self.setBadgeImage(delta: delta)
    }
    
    @objc func editTapped(_ sender: UIButton) {
        self.delegate?.openModal(data: self.data)
    }
    
    @objc func deleteTapped(_ sender: UIButton) {
        self.delegate?.deleteAlert(data: self.data!)
    }
    
    private func setBadgeImage(delta: Int) {
        var name: String!
        var color: UIColor!
        
        if delta > 0 {
            name = "arrow.up.right"
            color = UIColor.pink
        } else if delta == 0 {
            name = "arrow.forward"
            color = UIColor.gray
        } else {
            name = "arrow.down.right"
            color = UIColor.lightBlue
        }
        
        self.badgeImage.image = UIImage(systemName: name)?.withRenderingMode(.alwaysTemplate)
        self.badgeImage.tintColor = color
    }
    
}

class TableView: CardView {
    
    weak var delegate: DataProtocol?
    let tableView = UITableView()
    var records: [RecordData]!

    override init() {
        super.init()
        
        records = RecordData.getDataArray()
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.back
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func reloadData() {
        records = RecordData.getDataArray()
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
        let cell = TableCell(style: .default, reuseIdentifier: "tableCell")
        
        let delta = (indexPath.row == records.count - 1 ? 0 : records[indexPath.row].record - records[indexPath.row + 1].record)
        cell.setup(data: records[indexPath.row], delta: Int(delta), delegate: self.delegate)
        
        return cell
    }
    
}
