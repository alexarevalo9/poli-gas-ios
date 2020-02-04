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
import FirebaseCore
import FirebaseAuth


class ViewController: UIViewController {
    
    @IBOutlet weak var verificationid: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    
    
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityview.hidesWhenStopped = true
        activityview.isHidden = true
        verificationid.isHidden=true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
          performSegue(withIdentifier: "loginSuccessSegue", sender: self)
        }
    }
    
    var verification_id : String? = nil
    @IBAction func saveButton(_ sender: Any) {
        
        
        //activityview.isHidden = false
        //activityview.startAnimating()
        /*
         let llamardata = firestore.collection("data").document("prueba")
         
         llamardata.getDocument {(document, error) in
         if let document = document, document.exists {
         let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
         print("Document data: \(dataDescription)")
         
         
         } else {
         print("Document does not exist")
         }
         }*/
        
        /*
         firestore.collection("data").document("prueba").setData(
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
        if verificationid.isHidden {
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            PhoneAuthProvider.provider().verifyPhoneNumber(self.phone.text!, uiDelegate: nil) { (verificationID, error) in
                if (error != nil) {
                    return
                } else {
                    self.verification_id = verificationID
                    self.verificationid.isHidden = false
                }
            }
        } else {
            if verification_id != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id!, verificationCode: verificationid.text!)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if (error != nil) {
                    print(error.debugDescription)
                  } else {
                    print("SUCCESSS <AUTH" , (authResult?.user.phoneNumber! ?? "NO PHONE"))
                    self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
                    }
                }
                
            }else {
                print("EEEERRRRRORRRR")
            }
        }
        
        
    }
    
    
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alertController.addAction(okAlertAction)
        
        self.present(alertController, animated:true, completion: nil )
    }
    
    
}
