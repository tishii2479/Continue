//
//  SideMenu.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import UIKit

class MenuContent: UIView {
    
    weak var sideMenu: SideMenu?
    weak var delegate: DataProtocol?
    private var habits = Habit.getDataArray()
    let stackView = UIStackView()
    let tableView = UITableView()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 250, height: UIScreen.main.bounds.height))
        
        self.backgroundColor = UIColor.back
        self.addShadow()
        
        self.stackView.frame = self.bounds
        self.stackView.axis = .vertical
        self.stackView.alignment = .leading
        self.stackView.distribution = .fill
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        self.stackView.spacing = 30
        
        self.addSubview(self.stackView)
        
        let titleLabel = TextLabel()
        titleLabel.text = "一覧"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.stackView.addArrangedSubview(titleLabel)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.backgroundColor = UIColor.back
        self.stackView.addArrangedSubview(self.tableView)
        
        // FIXME:
        // constraint error
        // without this line, the table width will be zero
        NSLayoutConstraint.activate([
            self.tableView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor, constant: 20),
            self.tableView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor, constant: -20),
        ])
        
        let newButton = UIButton()
        newButton.setTitle("新規作成", for: .normal)
        newButton.setTitleColor(UIColor.pink, for: .normal)
        newButton.addTarget(self, action: #selector(newButtonTapped(_:)), for: .touchUpInside)
        self.stackView.addArrangedSubview(newButton)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func newButtonTapped(_ sender: UIButton) {
        self.delegate?.openNewHabit(isFirstLoad: false)
    }
    
    func reloadData() {
        self.habits = Habit.getDataArray()
        self.tableView.reloadData()
    }
    
}

extension MenuContent: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(self.habits[indexPath.row].id, forKey: RecordData.currentHabitKey)
        self.delegate?.reloadData()
        self.sideMenu?.fadeOut()
    }
    
}

extension MenuContent: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = habits[indexPath.row].name
        cell.textLabel?.textColor = UIColor.text
        cell.backgroundColor = UIColor.back
        cell.selectionStyle = .none
        
        return cell
    }
    
}

class SideMenu: UIView {
    
    var delegate: DataProtocol? {
        set {
            self.menu.delegate = newValue
        }
        get {
            return nil
        }
    }
    
    let blackMask = UIView()
    let menu = MenuContent()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.menu.sideMenu = self
        self.addShadow()
        
        self.blackMask.frame = CGRect(x: 0, y: 0, width: self.bounds.width * 2, height: self.bounds.height)
        self.blackMask.backgroundColor = UIColor.clear
        
        self.addSubview(blackMask)
        self.addSubview(menu)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fadeOut(_:)))
        self.blackMask.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(fadeOut(_:)))
        swipeGesture.direction = .left
        self.addGestureRecognizer(swipeGesture)
        
        // set side menu out of the screen
        self.center.x = -UIScreen.main.bounds.width / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func fadeOut(_ sender: UITapGestureRecognizer) {
        // fade out side menu
        fadeOut()
    }
    
    func fadeIn() {
        // fade in side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.x = UIScreen.main.bounds.width / 2
            self.blackMask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    
    func fadeOut() {
        // fade out side menu
        UIView.animate(withDuration: 0.5, animations: {
            self.center.x = -UIScreen.main.bounds.width / 2
            self.blackMask.backgroundColor = UIColor.clear
        })
    }
    
    func reloadData() {
        self.menu.reloadData()
    }
    
}
