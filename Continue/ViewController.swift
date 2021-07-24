//
//  ViewController.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setBackgroundColor()
        setTopBar()
        setNavigationBar()
        
        setLayout()
    }

    private func setBackgroundColor() {
        let gradientColors: [CGColor] = [UIColor.pink.cgColor, UIColor.lightBlue.cgColor]

        let gradientLayer: CAGradientLayer = CAGradientLayer()

        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setTopBar() {
        let topBar = TopBar()
        
        self.view.addSubview(topBar)
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.back
    }
    
    func setLayout() {}

}

