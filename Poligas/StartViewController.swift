//
//  StartViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 2/13/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var progressController: UIActivityIndicatorView!
      var totalTime = 3
      var countdownTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressController.startAnimating()
        startTimer()

        // Do any additional setup after loading the view.
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc func updateTime() {
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }

    func endTimer() {
        countdownTimer.invalidate()
        performSegue(withIdentifier: "homeViewSeggue", sender: self)
    }
    

    

}
