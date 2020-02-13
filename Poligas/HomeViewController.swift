//
//  HomeViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 1/31/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var carouselCards: iCarousel!
   // @IBOutlet weak var txtNUMERO: UITextField!
    @IBOutlet weak var lblNumero: UILabel!
    
    
    //arrayTanq
    var cardsImg = [
        UIImage(named: "BlueTankCard"),
        UIImage(named: "YellowTankCard"),
        UIImage(named: "IndusTankCard")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //cargar carrusel tipo rotary
        carouselCards.type = .rotary
        carouselCards.contentMode = .scaleToFill
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "typeRequestSegue"{
            let typeRequestView = segue.destination as! TypeOrderViewController
            typeRequestView.indice = carouselCards.currentItemIndex
            typeRequestView.numTanques = lblNumero.text ?? ""
        }
    }
    
    
    @IBAction func btnMas(_ sender: Any) {
    
        guard let f1 = Int(lblNumero.text!)else {
             return
         }
        if(f1<3){
         let suma = f1 + 1
         self.lblNumero.text = String(suma)
        }else{
             self.showAlert(title: "ALERTA", message: "Máximo 3 Tanques")
        }
    }
    

    @IBAction func btnmenos(_ sender: Any) {
        guard let f1 = Int(lblNumero.text!)else {
                    return
                }
        if (f1 != 1){
                let suma = f1 - 1
                self.lblNumero.text = String(suma)
    }else{
  self.showAlert(title: "ALERTA", message: "Minimo 1 Tanque")
    }
    }
  
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alertController.addAction(okAlertAction)
        
        present(alertController, animated:true, completion: nil )
    }

    //para obtener el indice de la carta seleccionada
    // let indice = carouselCards.currentItemIndex
    
    private func presentAlertWhit(title : String, message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            /*self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.emailTextField.becomeFirstResponder() */
        }
        
        alertController.addAction(okAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

//Funcion para la animacion y la vista
extension HomeViewController: iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return cardsImg.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 200))
            imageView.contentMode = .scaleAspectFit
        }else{
            imageView = view as? UIImageView
            
        }
        imageView.image = cardsImg[index]
        return imageView
    }
    
}

