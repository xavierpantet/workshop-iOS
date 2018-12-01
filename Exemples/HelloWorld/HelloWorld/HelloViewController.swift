//
//  HelloViewController.swift
//  HelloWorld
//
//  Created by Timothée Duran on 01.12.18.
//  Copyright © 2018 duran. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloLabel.text = name
    }

}
