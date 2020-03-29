//
//  editGroupViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 22/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class viewGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var lbGroupName: UILabel!
    @IBOutlet weak var lbGroupTheme: UILabel!
    @IBOutlet weak var lbGroupLeader: UILabel!
    @IBOutlet weak var lbLeaderPhone: UILabel!
    @IBOutlet weak var lbGroupStatus: UILabel!
    

    
    var studentArray = ["Matheus", "vazio", "vazio", "vazio", "vazio", "vazio", "vazio", "vazio", "vazio", "vazio", "vazio"]
    
    var teste: String = ""
    var groupName: String = ""
    var groupTheme: String = ""
    var ownerID: String = ""
    var status: String = ""
    var name: String = ""
    var phone: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        getGroupInfos()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.backItem!.title = "Voltar"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alunos", for: indexPath)
        
        cell.textLabel!.text = studentArray[indexPath.row]
        return cell
    }
    
    func getGroupInfos(){
        let db = Firestore.firestore()
        let docRef = db.collection("groups").document(teste)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.groupName = data!["groupName"] as! String
                self.groupTheme = data!["groupTheme"] as! String
                self.ownerID = data!["owner"] as! String
                self.status = data!["status"] as! String
                
                self.getOwnerInfo()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getOwnerInfo(){
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(ownerID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.name = data!["name"] as! String
                self.phone = data!["phone"] as! String
                self.showData()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func showData(){
        lbGroupName.text = "Grupo: \(groupName)"
        lbGroupTheme.text = "Tema: \(groupTheme)"
        lbGroupLeader.text = "Líder: \(name)"
        lbLeaderPhone.text = "Telefone: \(phone)"
        lbGroupStatus.text = "Status: \(status)"
    }
    
    
    
}
