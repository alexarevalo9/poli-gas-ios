//
//  SchedulerOrderTableViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 2/10/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit

class SchedulerOrderTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["data1", "data2", "data3", "data4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    

}
