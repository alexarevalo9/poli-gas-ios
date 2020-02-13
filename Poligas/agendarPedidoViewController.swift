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

class agendarPedidoViewController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate , UITextFieldDelegate{
    
    let calendario = UIDatePicker()
    let calendario2 = UIDatePicker()
    
    var indice = 1
    var numTanques = ""
    
    @IBOutlet weak var txtFechaEntrega: UITextField!
    @IBOutlet weak var txtHour: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var lblNumTanq: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtHour.delegate = self
        txtFechaEntrega.delegate = self
        calendario.datePickerMode = .dateAndTime
        calendario.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
        
        switch indice {
        case 1:
            cardImageView.image = UIImage(named: "YellowTankCard")
        case 2:
            cardImageView.image = UIImage(named: "IndusTankCard")
        default:
            cardImageView.image = UIImage(named: "BluwTankCard")
        }
        
        lblNumTanq.text = numTanques
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    @objc func dateValueChanged(_ sender: UIDatePicker) {
       
        let format2 = DateFormatter()
              format2.dateFormat = "HH:mm"
              txtHour.text = format2.string(from: calendario.date)
        let format = DateFormatter()
               format.dateFormat = "dd - MM - YYYY"
               txtFechaEntrega.text = format.string(from: calendario.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.tag ==  txtHour.tag && textField.tag == txtFechaEntrega.tag {
             textField.inputView = calendario
             textField.inputView = calendario 
     }
    
    }
}
