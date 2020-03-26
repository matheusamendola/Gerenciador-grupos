//
//  ConfigurationViewController.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 21/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit
import Firebase

class configurationViewController: UIViewController {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMatricula: UILabel!
    @IBOutlet weak var lbPhone: UITextField!
    @IBOutlet weak var lbPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
            showNavigationBar()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.backItem!.title = "Voltar"


        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigationBar()
    }
    
}
