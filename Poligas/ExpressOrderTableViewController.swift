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
    
    @IBOutlet weak var tableView: UITableView!
    var refresher: UIRefreshControl!
    var data = [""]
    var imageTank = [UIImage(named: "")]
    var numTank = [""]
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
        cell.imageView?.image = imageTank[indexPath.row]
        cell.detailTextLabel?.text = numTank[indexPath.row]
        return cell
    }
    
    func getExpressOrders(){
        
        let useruuid = Auth.auth().currentUser?.uid
        
        db.collection("expressorder").whereField("useruuid", isEqualTo: useruuid!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    self.imageTank.removeAll()
                    self.data.removeAll()
                    self.numTank.removeAll()
                    
                    for document in querySnapshot!.documents {
                        
                        self.data.append("Fecha: \(document.get("date") as! String)")
                        self.showImageTank(numberTank : document.get("typecylinder") as! Int)
                        self.numTank.append("Número de tanques: \(document.get("totalcylinder") as! String)")
                        print("\(document.documentID) => \(document.data())")
                    }
                    self.refresh()
                }
        }
        
    }
    
    func showImageTank(numberTank : Int){
        
        switch numberTank {
        case 1:
            imageTank.append(UIImage(named: "YellowTankCard"))
        case 2:
            imageTank.append(UIImage(named: "IndusTankCard"))
        default:
            imageTank.append(UIImage(named: "BlueTankCard"))
        }
        
    }
    
    @objc func refresh(){
        print("refreshed")
        self.tableView.reloadData()
        self.refresher.endRefreshing()
    }
    
    
    

}
