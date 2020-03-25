//
//  addPersonViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 22/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit

class addPersonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
