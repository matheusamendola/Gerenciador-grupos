//
//  CoursePickerViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 21/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit

class CoursePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    @IBOutlet weak var pkCourses: UIPickerView!
    
    var pickerData: [String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pkCourses.delegate = self
        self.pkCourses.dataSource = self
        
        pickerData = ["Administracao", "Arquitetura e Urbanismo", "Artes Cenicas", "Ciencia da Computacao", "Ciencias Contabeis", "Ciencias Economicas", "Design de Moda", "Design de Produto", "Direito", "Educacao Fisica", "Enfermagem", "Engenharia Civil", "Engenharia de Computacao", "Engenharia de Petroleo", "Engenharia de Producao", "Engenharia Eletrica", "Engenharia Mecanica", "Engenharia Quimica", "Estetica e Cosmetica", "Farmacia", "Fisioterapia", "Fonoaudiologia", "Fotografia", "Gastronomia", "Jornalismo", "Marketing", "Medicina", "Medicina Veterinaria", "Nutricao", "Odontologia", "Pedagogia", "Psicologia", "Publicidade e Propaganda", "Relacoes Internacionais", "Sistemas de Informacao"]
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
