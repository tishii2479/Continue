//
//  ViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    var sideMenu = SideMenu()
    let titleField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    private let viewMask = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setNavigationBar()
        
        setLayout()
    }

    private func setBackgroundColor() {
        /*
        let gradientColors: [CGColor] = [UIColor.pink.cgColor, UIColor.lightBlue.cgColor]

        let gradientLayer: CAGradientLayer = CAGradientLayer()

        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        self.view.layer.insertSublayer(gradientLayer, at: 0)
        */
        self.view.backgroundColor = UIColor.lightGray
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.back
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(fadeInMenu(_:)))
        menuButton.tintColor = UIColor.pink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    func setLayout() {
        self.navigationController?.view.addSubview(self.sideMenu)
        
        self.viewMask.frame = self.view.bounds
        self.viewMask.backgroundColor = UIColor.clear
        self.viewMask.isUserInteractionEnabled = false
        self.viewMask.layer.zPosition = 100
        self.view.addSubview(self.viewMask)
    }
    
    func setNavigationTitleText(title: String?) {
        if title == nil {
            self.titleField.text = "未設定"
            return
        }
        self.titleField.text = title
    }
    
    @objc func fadeInMenu(_ sender: UIBarButtonItem) {
        self.sideMenu.fadeIn()
    }
    
    func switchMask(isOn: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.viewMask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: (isOn ? 0.2 : 0))
        })
    }
    
}

