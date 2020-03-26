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
    @IBOutlet weak var btCreate: UIButton!
    
    private var userCollectionRef: CollectionReference!
    let USERS_REF = "users"

    var cargo: String = ""
    var groupName: String = ""
    var groupoCriado: String = ""
    var name: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        updateData()
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
        updateData()
    }
    
    func getUserData(){
        let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        let docRef = db.collection(USERS_REF).document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let data = document.data()
                
                self.cargo = data!["cargo"] as! String
                self.groupName = data!["groupName"] as! String
                self.groupoCriado = data!["grupoCriado"] as! String
                self.name = data!["name"] as! String
                
                self.updateData()
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateData(){
        lbName.text = "Olá, \(name)"
        lbGroup.text = "Groupo: \(groupName)"
        lbCargo.text = "\(cargo)"
        
        if groupoCriado == "0" {
            self.btCreate.setTitle("Criar Grupo", for: .normal)
            print(0)
        } else {
            self.btCreate.setTitle("Editar Grupo", for: .normal)
            print(1)
        }
        

    }
    
    @IBAction func createOrEdit(_ sender: UIButton) {
        if groupoCriado == "0" {
            performSegue(withIdentifier: "createGrupoSegue", sender: nil)
        }else{
            performSegue(withIdentifier: "editGroupSegue", sender: nil)
        }
    }
    
    
}
