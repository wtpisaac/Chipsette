//
//  ViewController.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/3/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        let safeArea = view.safeAreaLayoutGuide
        
        // Add label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, World!"
        label.textAlignment = .center
        view.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        
        
    }


}

