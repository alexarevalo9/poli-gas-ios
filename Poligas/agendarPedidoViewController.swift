//
//  agendarPedidoViewController.swift
//  Poligas
//
//  Created by ALEX VILATUÑA on 2/4/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class agendarPedidoViewController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate {

    let calendario = UIDatePicker()
    
    @IBOutlet weak var txtFechaEntrega: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //calendario
        calendario.datePickerMode = .date
        calendario.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }
    

  @objc func dateValueChanged(_ sender: UIDatePicker) {
         let format = DateFormatter()
         format.dateFormat = "DD - MM - YYYY"
         txtFechaEntrega.text = format.string(from: calendario.date)
     }

    
}
