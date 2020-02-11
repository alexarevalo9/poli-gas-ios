//
//  ExpressOrderTableViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 2/11/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseCore
import FirebaseAuth

class ExpressOrderTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
     var refresher: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    var data = ["key1", "example value 1"]
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "pull to refresh")
        refresher.addTarget(self, action: #selector(ExpressOrderTableViewController.refresh), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refresher)
        getExpressOrders()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func getExpressOrders(){
        
        let useruuid = Auth.auth().currentUser?.uid
        
        db.collection("expressorder").whereField("useruuid", isEqualTo: useruuid!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.refresh()
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }
        
    }
    
    @objc func refresh(){
        data = ["4","5"]
        print("refreshed")
        self.tableView.reloadData()
        self.refresher.endRefreshing()
    }
    
    
    

}
