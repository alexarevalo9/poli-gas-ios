//
//  ViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 12/11/19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
class ViewController: UIViewController {
    
    //imageView Type iCarousel
    @IBOutlet weak var carouselCards: iCarousel!
    
    //arrayTanq
    var cardsImg = [
        UIImage(named: "BlueTank"),
        UIImage(named: "YellowTank"),
        UIImage(named: "IndusTanq")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //cargar carrusel tipo rotary
        carouselCards.type = .rotary
        carouselCards.contentMode = .scaleToFill
    }

    //para obtener el indice de la carta seleccionada
    // let indice = carouselCards.currentItemIndex
    
    private func presentAlertWhit(title : String, message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            /*self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.emailTextField.becomeFirstResponder() */
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    let firestore = Firestore.firestore()
    //var ref: DatabaseReference!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityview.hidesWhenStopped = true
        activityview.isHidden = true
    }

    @IBAction func savebutton(_ sender: Any, completionHandler: @escaping ()->()) {
        activityview.isHidden = false
        activityview.startAnimating()
        
        let llamardata = firestore.collection("data").document("prueba")

        llamardata.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
            } else {
                print("Document does not exist")
            }
        }
        

       /* firestore.collection("data").document("prueba").setData(
  [
                 "phone": self.phone.text ?? "",
                 
             ]){ (error) in
              if error != nil {
                     self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                   }
              if error == nil {
              }
                 
             }
                       self.activityview.stopAnimating()
                    self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)*/
    }

    
    
    func showAlert(title: String, message: String){
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAlertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
           
           alertController.addAction(okAlertAction)
           
           present(alertController, animated:true, completion: nil )
       }
    
    
}

//Funcion para la animacion y la vista
extension ViewController: iCarouselDelegate, iCarouselDataSource{
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
