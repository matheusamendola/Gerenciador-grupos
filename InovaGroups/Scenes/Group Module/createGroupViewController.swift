//
//  createGroupViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 22/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class createGroupViewController: UIViewController {
    
    @IBOutlet weak var tfGroupName: UITextField!
    
    @IBOutlet weak var tfGroupTheme: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            hideNavigationBar()
        }
    
        override func viewWillAppear(_ animated: Bool) {
            showNavigationBar()
        }
    
    @IBAction func create(_ sender: Any){
        
        let name = tfGroupName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = tfGroupTheme.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        let owner = Auth.auth().currentUser?.uid
        
        let studentArray = [owner, "0", "0", "0", "0", "0", "0", "0", "0", "0"]
        let identifier = UUID().uuidString
        
        db.collection("groups").document(identifier).setData(["groupName": name,
        "groupTheme": theme,
        "owner": owner ?? 0,
        "status": "ABERTO",
        "studentArray" : studentArray])
        
        db.collection("users").document(owner!).updateData([
            "group": identifier, "groupName": name, "cargo": "Lider", "grupoCriado": "1"])
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
