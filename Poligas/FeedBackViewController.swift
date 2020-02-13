//
//  FeedBackViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 2/13/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class FeedBackViewController: UIViewController {
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var FeedBackTextView: UITextField!
    
    @IBAction func feedBackButton(_ sender: Any) {
        
        let useruuid = Auth.auth().currentUser?.uid
        
        db.collection("feedBack").addDocument(data: [
            "commentary": FeedBackTextView.text ?? "",
            "uuide": useruuid!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Order Scheduler added successfully")
            }
        }
        
    }
    
    

}
