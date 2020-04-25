//
//  PersonViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 25/04/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class PersonViewController: UIViewController {
    //MARK: - Definicoes
    let USERS_REF = "users"
    
    //MARK: - Outlets
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCargo: UILabel!
    @IBOutlet weak var lbCourse: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    
    @IBOutlet weak var lbGroup: UILabel!
    @IBOutlet weak var lbTheme: UILabel!
    @IBOutlet weak var lbLeader: UILabel!
    @IBOutlet weak var lbLeaderPhone: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    @IBOutlet weak var viLoading: UIView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    // MARK: - variaveis
    var selectedStudent = ""
    
    var nome: String = ""
    var cargo: String = ""
    var curso: String = ""
    var telefone: String = ""
    
    var grupoID: String = ""
    var grupoNome: String = ""
    var groupTheme: String = ""
     var groupLeaderName: String = ""
    var groupLeaderID: String = ""
    var groupPhone: String = ""
    var groupStatus: String = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
        self.load(show: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func load(show: Bool) {
        viLoading.isHidden = !show
        if show{
            aiLoading.startAnimating()
        }
        else{
            aiLoading.stopAnimating()
        }
    }
    
    func getUserData(){
        let db = Firestore.firestore()
        let userID = selectedStudent
        let docRef = db.collection(USERS_REF).document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.nome = data!["name"] as! String
                self.cargo = data!["cargo"] as! String
                self.curso = data!["curso"] as! String
                self.telefone = data!["phone"] as! String
                self.grupoID = data!["group"] as! String
                
                
                
                self.getGroupInfos()
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getGroupInfos(){
        let db = Firestore.firestore()
        let docRef = db.collection("groups").document(grupoID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                self.grupoNome = data!["groupName"] as! String
                self.groupTheme = data!["groupTheme"] as! String
                self.groupLeaderID = data!["owner"] as! String
                self.groupStatus = data!["status"] as! String
                self.getGroupOwnerInfos()

            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getGroupOwnerInfos(){
        let db = Firestore.firestore()
        let userID = groupLeaderID
        let docRef = db.collection(USERS_REF).document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.groupLeaderName = data!["name"] as! String
                self.groupPhone = data!["phone"] as! String
                self.updateData()
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateData(){
        self.load(show: false)
        //Informacoes da Pessoa
        lbName.text = "Nome: \(nome)"
        lbCargo.text = "Cargo: \(cargo)"
        lbCourse.text = "Curso: \(curso)"
        lbPhone.text = "Telefone: \(telefone)"
        
        //informacoes de Grupo
        lbGroup.text = "Grupo: \(grupoNome)"
        lbTheme.text = "Tema: \(groupTheme)"
        lbLeader.text = "Líder: \(groupLeaderName)"
        lbLeaderPhone.text = "Telefone: \(groupPhone)"
        lbStatus.text = "Status: \(groupStatus)"
    }
    
    
}
