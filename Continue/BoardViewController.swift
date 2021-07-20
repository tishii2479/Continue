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
    
    override func setLayout() {
        let cardView = CardView(size: CGSize(width: 100, height: 100))
        
        self.view.addSubview(cardView)
    }

}
