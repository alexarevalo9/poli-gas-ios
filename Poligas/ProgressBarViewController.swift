//
//  ProgressBarViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 1/21/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar

class ProgressBarViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    var progressBar: FlexibleSteppedProgressBar!
    var backgroundColor = UIColor(red: 218.0 / 255.0, green: 218.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
    var progressColor = UIColor(red: 67.0 / 255.0, green: 156.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    var textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    var maxIndex = -1
    var counter = 0
    var currentState = 1
    var state = 0
    var countdownTimer: Timer!
    var totalTime = 0
    
    
    @IBOutlet weak var poligasProgressTextView: UILabel!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicatorView.startAnimating()
        setupProgressBar()
        totalTime = Int.random(in: 5..<10)
        startTimer()
        
        
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
        currentStateBar()
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func orderProgressBar(state : Int){
        
        switch state {
        case 1:
            currentState = 1
            totalTime = Int.random(in: 5..<10)
            startTimer()
        case 2:
            poligasProgressTextView.text = "Su pedido esta en camino"
            currentState = 2
            totalTime = Int.random(in: 5..<10)
            startTimer()
        case 3:
            poligasProgressTextView.text = "Tú pedido espera por ti"
            currentState = 3
            totalTime = Int.random(in: 5..<10)
            startTimer()
        case 4:
            progressIndicatorView.stopAnimating()
            poligasProgressTextView.text = "Gracias por usar nuestra app"
            self.performSegue(withIdentifier: "feedBackSegue", sender: self)
            //commentButton.isHidden = false
        default:
            print("Progress  Bar Error")
        }
        
    }
    
    func currentStateBar() {
        switch currentState {
        case 1:
            progressBar.currentIndex = 1
            orderProgressBar(state : 2)
        case 2:
            progressBar.currentIndex = 2
            orderProgressBar(state : 3)
        case 3:
            progressBar.currentIndex = 3
            orderProgressBar(state : 4)
            currentState = 0
        default:
            print("Progress  Bar Error")
            break
        }
    }



    /*
    func countDownTimer(){
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            countDownLabel.text = String(counter)
            counter = counter - 1
        }else{
            countDownLabel.text = "FINISH"
            //currentStateBar()
            switch state {
            case 1:
                state = 2
                counter = Int.random(in: 1..<10)
                countDownTimer()
            case 2:
                state = 2
                counter = Int.random(in: 1..<10)
                countDownTimer()
            case 3:
                state = 3
                counter = Int.random(in: 1..<10)
                countDownTimer()
            case 4:
                state = 4
                counter = Int.random(in: 1..<10)
                countDownTimer()
            default:
                print("Progress  Bar Error2 ")
            }
        }
    }*/
    /*
    func currentStateBar() {
        switch currentState {
        case 1:
            progressBar.currentIndex = 1
            orderProgressBar(state : 2)
        case 2:
            progressBar.currentIndex = 2
            orderProgressBar(state : 3)
        case 3:
            progressBar.currentIndex = 3
            orderProgressBar(state : 5)
            currentState = 0
        default:
            print("Progress  Bar Error 1")
            break
        }
    }*/
    /*
    func orderProgressBar(state : Int){
        
        switch state {
        case 1:
            currentState = 1
            counter = Int.random(in: 1..<10)
            countDownTimer()
        case 2:
            currentState = 2
            counter = Int.random(in: 1..<10)
            countDownTimer()
        case 3:
            currentState = 3
            counter = Int.random(in: 1..<10)
            countDownTimer()
        case 4:
            currentState = 4
            counter = Int.random(in: 1..<10)
            countDownTimer()
        default:
            print("Progress  Bar Error2 ")
        }
        
    }*/
    
    func setupProgressBar() {
        progressBar = FlexibleSteppedProgressBar()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressBar)
        
        // iOS9+ auto layout code
        let horizontalConstraint = progressBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let verticalConstraint = progressBar.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 80
        )
        let widthConstraint = progressBar.widthAnchor.constraint(equalToConstant: 350)
        let heightConstraint = progressBar.heightAnchor.constraint(equalToConstant: 700)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        // Customise the progress bar here
        progressBar.numberOfPoints = 4
        progressBar.lineHeight = 3
        progressBar.radius = 10
        progressBar.progressRadius = 15
        progressBar.progressLineHeight = 3
        progressBar.delegate = self
        progressBar.selectedBackgoundColor = progressColor
        progressBar.selectedOuterCircleStrokeColor = backgroundColor
        progressBar.currentSelectedCenterColor = progressColor
        progressBar.stepTextColor = textColorHere
        progressBar.currentSelectedTextColor = progressColor
        progressBar.currentIndex = 0
        
    }
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, didSelectItemAtIndex index: Int) {
        progressBar.currentIndex = index
        if index > maxIndex {
            maxIndex = index
            progressBar.completedTillIndex = maxIndex
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        progressBar.currentIndex = 2
    }
    
    
    func progressBar(_ progressBar: FlexibleSteppedProgressBar,textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        if position == FlexibleSteppedProgressBarTextLocation.top {
            switch index {
                
            case 0: return ""
            case 1: return ""
            case 2: return ""
            case 3: return ""
            case 4: return ""
            default: return ""
                
            }
        }else if position == FlexibleSteppedProgressBarTextLocation.bottom {
            switch index {
                
            case 0: return ""
            case 1: return ""
            case 2: return ""
            case 3: return ""
            case 4: return ""
            default: return ""
                
            }
        }else if position == FlexibleSteppedProgressBarTextLocation.center {
            switch index {
                
            case 0: return "1"
            case 1: return "2"
            case 2: return "3"
            case 3: return "4"
            case 4: return "5"
            default: return "0"
                
            }
        }
        
        return ""
    }
            
}
