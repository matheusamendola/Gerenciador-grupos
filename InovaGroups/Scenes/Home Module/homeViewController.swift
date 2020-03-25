//
//  homeViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 23/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class homeViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGroup: UILabel!
    @IBOutlet weak var lbCargo: UILabel!
    
    
    private var userCollectionRef: CollectionReference!
    let USERS_REF = "users"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        
        let docRef = db.collection(USERS_REF).document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let data = document.data()
                let name = data!["name"] as? String ?? "Sem Nome"
                let phone = data!["phone"] as? String ?? "Sem Numero"
                let group = data!["group"] as? String ?? "Sem Grupo"
                let cargo = data!["cargo"] as? String ?? "Sem Cargo"
                
                print(name)
                
                self.lbName.text = "Olá, \(name)"
                self.lbGroup.text = "Groupo: \(group)"
                self.lbCargo.text = "\(cargo)"
                

                
            } else {
                print("Document does not exist")
            }
        }

        }
    



}
