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
    let db = Firestore.firestore()
    
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
            cardImageView.image = UIImage(named: "BlueTankCard")
        }
        
        lblNumTanq.text = numTanques
        
    }
    
    @IBAction func schedulerOrderButton(_ sender: Any) {
        
        if(txtFechaEntrega.text != "" && txtHour.text != ""){
            saveSchedulerOrder()
    
        }else{
            showAlert(title: "ALERTA", message: "Debe llenar los campos de fecha y hora")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alertController.addAction(okAlertAction)
        
        present(alertController, animated:true, completion: nil )
    }
    
    func saveSchedulerOrder(){
        
        let useruuid = Auth.auth().currentUser?.uid
        
        db.collection("shcedulerorder").addDocument(data: [
            "typecylinder": indice,
            "totalcylinder": numTanques,
            "date":"\(txtFechaEntrega.text!) \(txtHour.text!)",
            "useruuid": useruuid ?? ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.performSegue(withIdentifier: "homeViewSegue", sender: self)
                self.showAlert(title: "MENSAJE", message: "Su pedido ha sido agendado correctamente!")
                print("Order Scheduler added successfully")
            }
        }
    }
    
    @objc func dateValueChanged(_ sender: UIDatePicker) {
       
        let format2 = DateFormatter()
              format2.timeStyle = .short
              txtHour.text = format2.string(from: calendario.date)
        let format = DateFormatter()
               format.dateStyle = .short
               txtFechaEntrega.text = format.string(from: calendario.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.tag ==  txtHour.tag && textField.tag == txtFechaEntrega.tag {
             textField.inputView = calendario
             textField.inputView = calendario 
     }
    
    }
}
