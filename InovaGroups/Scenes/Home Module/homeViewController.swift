//
//  homeViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 23/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//
import UIKit
import Firebase

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Menu
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGroup: UILabel!
    @IBOutlet weak var lbCargo: UILabel!
    @IBOutlet weak var btCreate: UIButton!
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    private var userCollectionRef: CollectionReference!
    let USERS_REF = "users"
    
    var groupArray = [String]()
    var nomeGrupo: String = ""
    

    var cargo: String = ""
    var groupName: String = ""
    var groupoCriado: String = ""
    var name: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    

    override func viewWillAppear(_ animated: Bool) {
        getUserData()
        updateData()
        getGroupList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigationBar()
        groupArray.removeAll()

    }
    
    
    func getGroupList(){
        let db = Firestore.firestore()
        db.collection("groups").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        self.nomeGrupo = data["groupName"] as! String
                        self.groupArray.append(self.nomeGrupo)
                        self.nomeGrupo = ""
                    }
                    //self.myTableView.dataSource = self
                    //self.myTableView.delegate = self
                }
        }
    }
    

    func getUserData(){
        let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        let docRef = db.collection(USERS_REF).document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //print("Document data: \(dataDescription)")
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
        } else {
            self.btCreate.setTitle("Editar Grupo", for: .normal)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(groupArray.count)
        return groupArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "grupos", for: indexPath)
        
        cell.textLabel!.text = groupArray[indexPath.row]
        return cell
    }
    
    @IBAction func createOrEdit(_ sender: UIButton) {
        if groupoCriado == "0" {
            performSegue(withIdentifier: "createGrupoSegue", sender: nil)

        }else{
            performSegue(withIdentifier: "editGroupSegue", sender: nil)
        }
    }
    
    
}
