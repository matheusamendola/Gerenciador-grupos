//
//  addPersonViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 22/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class addPersonViewController: UIViewController {
    
    var studentArray = [String]() //ID
    
    @IBOutlet weak var tfMatricula: UITextField!
    var teste: String = ""
    
    func getStudentArray(){
        Firestore.firestore().collection("groups").document(teste).getDocument { (document, error) in
            if let document = document {
                self.studentArray = document["studentArray"] as! Array
            }
            print(self.studentArray)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStudentArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func sendToFirebase(){
        let db = Firestore.firestore()
        db.collection("groups").document(teste).setData(["studentArray" : studentArray])
        dismiss(animated: true, completion: nil)
    }
    // TODO: PEgar matricula e converter para o uid
    
    private func deleteField() {
        let db = Firestore.firestore()
        db.collection("groups").document(teste).updateData([
            "studentArray": studentArray
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func alterArrayLocal(){
        //Alterar a array do localmente
        var index = 0
        var flagAdded = 0
        for i in studentArray{
            if i == "0"{
                if flagAdded == 0{
                    self.studentArray.remove(at: index)
                    self.studentArray.insert(tfMatricula.text!, at: index)
                    index = index + 1
                    flagAdded = 1
                }
            }
            index = index + 1
        }
        print(studentArray)
        
        //Alterar a array no banco
        deleteField()
    }
    
    @IBAction func confirm(_ sender: Any) {
        alterArrayLocal()
    }
}
