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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressBar()
    }
    
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
                
            case 0: return "Choose"
            case 1: return "Click"
            case 2: return "Checkout"
            case 3: return "Buy"
            case 4: return "Pay"
            default: return "Step"
                
            }
        }else if position == FlexibleSteppedProgressBarTextLocation.bottom {
            switch index {
                
            case 0: return "First"
            case 1: return "Second"
            case 2: return "Third"
            case 3: return "Fourth"
            case 4: return "Fifth"
            default: return "Date"
                
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
