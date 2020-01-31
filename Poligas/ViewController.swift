//
//  ViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 12/11/19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
class ViewController: UIViewController {
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    let firestore = Firestore.firestore()
    //var ref: DatabaseReference!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityview.hidesWhenStopped = true
        activityview.isHidden = true
    }

    @IBAction func savebutton(_ sender: Any, completionHandler: @escaping ()->()) {
        activityview.isHidden = false
        activityview.startAnimating()
        
        let llamardata = firestore.collection("data").document("prueba")

        llamardata.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
            } else {
                print("Document does not exist")
            }
        }
        

       /* firestore.collection("data").document("prueba").setData(
  [
                 "phone": self.phone.text ?? "",
                 
             ]){ (error) in
              if error != nil {
                     self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                   }
              if error == nil {
              }
                 
             }
                       self.activityview.stopAnimating()
                    self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)*/
    }

    
    
    func showAlert(title: String, message: String){
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAlertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
           
           alertController.addAction(okAlertAction)
           
           present(alertController, animated:true, completion: nil )
       }
    
}

