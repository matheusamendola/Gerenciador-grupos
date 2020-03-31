//
//  registerViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 21/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class registerViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfMatricula: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfCurso: UITextField!
    

    
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
    
    func validateField() -> String?{
        if tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            tfMatricula.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            tfPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            tfCurso.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Entre com todos os campos"
        }

        return nil
    }
    
    @IBAction func cadastrar(_ sender: Any) {
        
        let error = validateField()
        
        if error != nil {
            print("Erro")
        }
        else{
            //Limpar Campos
            let name = tfName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let matricula = tfMatricula.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = tfPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let curso = tfCurso.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    print("Erro")
                }
                else{
                    let db = Firestore.firestore()
                    let owner = (Auth.auth().currentUser?.uid)!
                    db.collection("users").document(owner).setData([
                        "curso": curso,
                        "name":name,
                        "matricula":matricula,
                        "phone":phone,
                        "uid":result!.user.uid,
                        "group": "nil",
                        "groupName": "Sem grupo",
                        "cargo": "Aluno",
                        "grupoCriado": "0"]){ (error) in
                        if error != nil {
                            print("Erro")
                        }
                    }
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome(){
        performSegue(withIdentifier: "homeScreen", sender: nil)
    }
}

