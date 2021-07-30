//
//  ViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    var sideMenu = SideMenu()
    
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
        self.navigationItem.title = "新しい習慣"
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.text,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(fadeInMenu(_:)))
        menuButton.tintColor = UIColor.pink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    func setLayout() {
        self.navigationController?.view.addSubview(sideMenu)
    }
    
    @objc func fadeInMenu(_ sender: UIBarButtonItem) {
        self.sideMenu.fadeIn()
    }
    
}

