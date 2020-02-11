//
//  TypeOrderViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 2/10/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseCore
import FirebaseAuth

class TypeOrderViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveExpressOrder()
        
    }
    
    func saveExpressOrder(){
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        let date = formatter.string(from: currentDateTime)
            
        let useruuid = Auth.auth().currentUser?.uid
        
        db.collection("expressorder").addDocument(data: [
            "typecylinder": "1",
            "totalcylinder": "1",
            "date": date,
            "useruuid": useruuid ?? ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Order Express added successfully")
            }
        }
    }
    
    func saveSchedulerOrder(){
        
        let useruuid = Auth.auth().currentUser?.uid
        
        db.collection("shcedulerorder").addDocument(data: [
            "typecylinder": "1",
            "totalcylinder": "1",
            "date":"123",
            "hour":"345",
            "useruuid": useruuid ?? ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Order Express added successfully")
            }
        }
        
    }
    
}
