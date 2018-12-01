//
//  ViewController.swift
//  HelloWorld
//
//  Created by Timothée Duran on 01.12.18.
//  Copyright © 2018 duran. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Cette partie de code est appelé quand l'utilisateur presse sur le boutton
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //On créer une variable qui contient une instance de notre view controller suivant
        if let helloViewController = segue.destination as? HelloViewController {
            
            //On assigne la variable name avec le contenu de notre TextField
            helloViewController.name = nameTextField.text
        }
        
    }

}

