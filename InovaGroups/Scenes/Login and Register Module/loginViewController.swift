//
//  ViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 19/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    
    //Table View
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    @IBAction func login(_ sender: UIButton) {
        let email = tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = tfSenha.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("Erro")
            }
            else {
                self.performSegue(withIdentifier: "goHome", sender: sender)
            }
        }
        
    }
    
}

extension UIViewController {
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}


