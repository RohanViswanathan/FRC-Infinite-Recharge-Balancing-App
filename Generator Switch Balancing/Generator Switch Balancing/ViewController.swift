//
//  ViewController.swift
//  Generator Switch Balancing
//
//  Created by Rohan Viswanathan on 1/19/20.
//  Copyright © 2020 Team 3256. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //length of Generator Switch is 111.26 inches, so max hanging position is +- 55 inches
    //positive distance is to the right, negative distance is to the left
    //position displayed is scaled from left-most point being 0, so conversion (given that v is slider value and p is displayed value is (p = 110v-55)
    
    @IBOutlet weak var R1PositionSlider: UISlider!
    @IBOutlet weak var R1PositionLabel: UILabel!
    @IBOutlet weak var R1Weight: UITextField!
    @IBOutlet weak var R1CoGOffset: UITextField!
    @IBOutlet weak var AngleLabel: UILabel!
    var angle = Float(0.0);
    var R1Position = Float(0.0);
    var generatorSwitchHeight = Float(48.375)
    var generatorSwitchCOMHeight = Float(26.0)
    var generatorSwitchMass = Float(93.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        R1PositionSlider.thumbTintColor = .blue
        R1PositionSlider.minimumTrackTintColor = .gray
        R1PositionSlider.maximumTrackTintColor = .gray
        R1PositionSlider.value = 0
        R1Weight.text = "0"
        R1CoGOffset.text = "0"
        // Do any additional setup after loading the view.
    }

    @IBAction func R1PositionSliderChanged(_ sender: Any) {
        R1Position = (110*(R1PositionSlider.value)) - 55
        R1PositionLabel.text = "\(R1Position)"
    }
    
    @IBAction func CalculateAngle(_ sender: Any) {
        updateAngle()
    }
    @objc func updateAngle() {
        let R1WeightFloat: Float? = Float(R1Weight.text!)
        let R1CoGOffsetFloat: Float? = Float(R1CoGOffset.text!)
        let numerator = (R1WeightFloat!*R1Position)
        let denominator = (R1WeightFloat!*(generatorSwitchHeight + R1CoGOffsetFloat!)) + (generatorSwitchMass * generatorSwitchCOMHeight)
        angle = atan(-numerator/denominator) * 180 / Float.pi
        AngleLabel.text = "\(angle)"
        if (angle > 8) {
            AngleLabel.textColor = .red
        }
        else {
            AngleLabel.textColor = UIColor(red:0.1, green:0.80, blue:0.10, alpha:1.0)
        }
    }
    
}

