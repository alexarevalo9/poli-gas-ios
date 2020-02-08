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
    
    @IBOutlet weak var txtFechaEntrega: UITextField!
    @IBOutlet weak var txtHour: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendario.datePickerMode = .date
        calendario2.datePickerMode = .time
        txtFechaEntrega.delegate = self
        txtHour.delegate = self
        calendario.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
        
    }
    
    
    @objc func dateValueChanged(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "dd - MM - YYYY"
        txtFechaEntrega.text = format.string(from: calendario.date)
    }
    
    @objc func dateValueChanged2(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        txtHour.text = format.string(from: calendario2.date)
    }
    /*
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == txtFechaEntrega.tag {
            textField.inputView = calendario
        }
        
    }
    */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == txtHour.tag {
            textField.inputView = calendario2
        }
    }
    
}
