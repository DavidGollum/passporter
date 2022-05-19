//
//  ViewController.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let initialVC = ListPlacesViewController()
        navigationController?.pushViewController(initialVC, animated: true)
    }
    
}

