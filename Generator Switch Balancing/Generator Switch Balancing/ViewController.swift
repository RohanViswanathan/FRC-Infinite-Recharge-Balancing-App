//
//  ViewController.swift
//  Generator Switch Balancing
//
//  Created by Rohan Viswanathan on 1/19/20.
//  Copyright © 2020 Team 3256. All rights reserved.
//

import UIKit
import MultiSlider

class ViewController: UIViewController {

    //length of Generator Switch is 111.26 inches, so max hanging position is +- 55 inches
    //positive distance is to the right, negative distance is to the left
    //position displayed is scaled from left-most point being 0, so conversion (given that v is slider value and p is displayed value is (p = 110v-55)
    
    @IBOutlet weak var R1PositionSlider: UISlider!
    @IBOutlet weak var R2PositionSlider: UISlider!
    @IBOutlet weak var R3PositionSlider: UISlider!
    @IBOutlet weak var R1PositionLabel: UILabel!
    @IBOutlet weak var R2PositionLabel: UILabel!
    @IBOutlet weak var R3PositionLabel: UILabel!
    @IBOutlet weak var R1Weight: UITextField!
    @IBOutlet weak var R2Weight: UITextField!
    @IBOutlet weak var R3Weight: UITextField!
    @IBOutlet weak var R1CoGOffset: UITextField!
    @IBOutlet weak var R2CoGOffset: UITextField!
    @IBOutlet weak var R3CoGOffset: UITextField!
    @IBOutlet weak var AngleLabel: UILabel!
    var angle = Float(0.0);
    var R1Position = Float(0.0);
    var R2Position = Float(0.0);
    var R3Position = Float(0.0);
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
        
        R2PositionSlider.thumbTintColor = .orange
        R2PositionSlider.minimumTrackTintColor = .gray
        R2PositionSlider.maximumTrackTintColor = .gray
        R2PositionSlider.value = 1
        R2Weight.text = "0"
        R2CoGOffset.text = "0"
        
        R3PositionSlider.thumbTintColor = .purple
        R3PositionSlider.minimumTrackTintColor = .gray
        R3PositionSlider.maximumTrackTintColor = .gray
        R3PositionSlider.value = 0.5
        R3Weight.text = "0"
        R3CoGOffset.text = "0"

        
        // Do any additional setup after loading the view.
    }

    @IBAction func R1PositionSliderChanged(_ sender: Any) {
        R1Position = (110*(R1PositionSlider.value)) - 55
        R1PositionLabel.text = "\(R1Position)"
    }
    
    @IBAction func R2PositionSliderChanged(_ sender: Any) {
        R2Position = (110*(R2PositionSlider.value)) - 55
        R2PositionLabel.text = "\(R2Position)"
    }
    
    @IBAction func R3PositionSliderChanged(_ sender: Any) {
        R3Position = (110*(R3PositionSlider.value)) - 55
        R3PositionLabel.text = "\(R3Position)"
    }
    
    @IBAction func CalculateAngle(_ sender: Any) {
        updateAngle()
    }
    
    @objc func updateAngle() {
        let R1WeightFloat: Float? = Float(R1Weight.text!)
        let R1CoGOffsetFloat: Float? = Float(R1CoGOffset.text!)
        let R2WeightFloat: Float? = Float(R2Weight.text!)
        let R2CoGOffsetFloat: Float? = Float(R2CoGOffset.text!)
        let R3WeightFloat: Float? = Float(R3Weight.text!)
        let R3CoGOffsetFloat: Float? = Float(R3CoGOffset.text!)
        let numerator = (R1WeightFloat!*R1Position) + (R2WeightFloat!*R2Position) + (R3WeightFloat!*R3Position)
        let denominator = (R1WeightFloat!*(generatorSwitchHeight + R1CoGOffsetFloat!)) + (R2WeightFloat!*(generatorSwitchHeight + R2CoGOffsetFloat!)) + (R3WeightFloat!*(generatorSwitchHeight + R3CoGOffsetFloat!)) + (generatorSwitchMass * generatorSwitchCOMHeight)
        angle = atan(-numerator/denominator) * 180 / Float.pi
        AngleLabel.text = "\(angle)"
        if (angle > 8) {
            AngleLabel.textColor = .red
        }
        else if (angle < -8) {
            AngleLabel.textColor = .red
        }
        else {
            AngleLabel.textColor = UIColor(red:0.1, green:0.80, blue:0.10, alpha:1.0)
        }
    }
    
}
