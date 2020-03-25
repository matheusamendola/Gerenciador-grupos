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
        showNavigationBar()
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.isTranslucent = true
                self.navigationController!.navigationBar.backItem!.title = "Voltar"
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            hideNavigationBar()
        }
    
    @IBAction func create(_ sender: Any) {
        let name = tfGroupName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = tfGroupTheme.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        let owner = Auth.auth().currentUser?.uid
        
        let studentArray = [owner, "", "", "", "", "", "", "", "", "", ""]
        
        db.collection("groups").addDocument(data:
            ["groupName": name,
             "groupTheme": theme,
             "owner": owner ?? 0,
             "status": "ABERTO",
             "studentArray" : studentArray])
        
        performSegue(withIdentifier: "goToGroup", sender: nil)
        
    }
    
}
