//
//  sendDeleteAcountViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 22/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase


class sendDeleteAcountViewController: UIViewController {
    
    @IBOutlet weak var tfPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        let user = Auth.auth().currentUser

        user?.delete { error in
            if error != nil {
            // An error happened.
          } else {
            // Account deleted.
            print("Deletada")
                
          }
        }
        dismiss(animated: true, completion: nil)
    }
}
