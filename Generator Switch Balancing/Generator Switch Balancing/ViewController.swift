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
        let mainColors: [UIColor] = [UIColor.blue, UIColor.orange, UIColor.purple, UIColor.gray]
        
        R1PositionSlider.thumbTintColor = mainColors[0]
        R1PositionSlider.minimumTrackTintColor = mainColors[3]
        R1PositionSlider.maximumTrackTintColor = mainColors[3]
        R1PositionSlider.value = 0
        R1Weight.text = "0"
        R1CoGOffset.text = "0"
        
        R2PositionSlider.thumbTintColor = mainColors[1]
        R2PositionSlider.minimumTrackTintColor = mainColors[3]
        R2PositionSlider.maximumTrackTintColor = mainColors[3]
        R2PositionSlider.value = 1
        R2Weight.text = "0"
        R2CoGOffset.text = "0"
        
        R3PositionSlider.thumbTintColor = mainColors[2]
        R3PositionSlider.minimumTrackTintColor = mainColors[3]
        R3PositionSlider.maximumTrackTintColor = mainColors[3]
        R3PositionSlider.value = 0.5
        R3Weight.text = "0"
        R3CoGOffset.text = "0"

        
        // Do any additional setup after loading the view.
    }

    @IBAction func R1PositionSliderChanged(_ sender: Any) {
        R1Position = (110*(R1PositionSlider.value)) - 55
        R1PositionLabel.text = "\(R1Position)"
        updateAngle()
    }
    
    @IBAction func R2PositionSliderChanged(_ sender: Any) {
        R2Position = (110*(R2PositionSlider.value)) - 55
        R2PositionLabel.text = "\(R2Position)"
        updateAngle()
    }
    
    @IBAction func R3PositionSliderChanged(_ sender: Any) {
        R3Position = (110*(R3PositionSlider.value)) - 55
        R3PositionLabel.text = "\(R3Position)"
        updateAngle()
    }
    
    @IBAction func CalculateAngle(_ sender: Any) {
        updateView()
        updateAngle()
    }
    
    @objc func updateView() {
        if (Float(R1Weight.text!) == 0) {
            R1PositionSlider.isHidden = true
        }
        else if (Float(R2Weight.text!) == 0) {
            R2PositionSlider.isHidden = true
        }
            
        else if (Float(R3Weight.text!) == 0) {
            R3PositionSlider.isHidden = true
        }
            
        else {
            R1PositionSlider.isHidden = false
            R2PositionSlider.isHidden = false
            R3PositionSlider.isHidden = false
        }
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

