import UIKit
import Firebase

class configurationViewController: UIViewController {
    
    private var userCollectionRef: CollectionReference!
    let USERS_REF = "users"
    
    //Outlets
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCourse: UILabel!
    @IBOutlet weak var lbMatricula: UILabel!
    @IBOutlet weak var lbTelefone: UILabel!
    @IBOutlet weak var lbGrupo: UILabel!
    @IBOutlet weak var lbCargo: UILabel!
    
    var name: String = ""
    var curso: String = ""
    var matricula: String = ""
    var telefone: String = ""
    var grupoNome: String = ""
    var cargo: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
            showNavigationBar()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.backItem!.title = "Voltar"
        


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        getUserData()
    }
    
    func getUserData(){
        let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        let docRef = db.collection(USERS_REF).document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //print("Document data: \(dataDescription)")
                let data = document.data()
                
                 self.name = data!["name"] as! String
                 self.curso = data!["curso"] as! String
                 self.matricula = data!["matricula"] as! String
                 self.telefone = data!["phone"] as! String
                 self.grupoNome = data!["groupName"] as! String
                 self.cargo = data!["cargo"] as! String

                 self.updateData()
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateData(){
        
        lbName.text = "Nome: \(name)"
        lbCourse.text = "Curso: \(curso)"
        lbMatricula.text = "Matricula: \(matricula)"
        lbTelefone.text = "Telefone: \(telefone)"
        lbGrupo.text = "Groupo: \(grupoNome)"
        lbCargo.text = "Cargo: \(cargo)"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigationBar()
    }
    
}
