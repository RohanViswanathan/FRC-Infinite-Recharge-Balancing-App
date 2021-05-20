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
    //position displayed is scaled from left-most point being 0, so conversion (given that v is slider value and p is displayed value is (p = 110v-55))
    
    //declaring the UI Sliders and their Position Label objects
    @IBOutlet weak var R1PositionSlider: UISlider! 
    @IBOutlet weak var R2PositionSlider: UISlider!
    @IBOutlet weak var R3PositionSlider: UISlider!
    @IBOutlet weak var R1PositionLabel: UILabel!
    @IBOutlet weak var R2PositionLabel: UILabel!
    @IBOutlet weak var R3PositionLabel: UILabel!
    
    //declaring the text input fields for robot weights and center of gravity offsets
    @IBOutlet weak var R1Weight: UITextField!
    @IBOutlet weak var R2Weight: UITextField!
    @IBOutlet weak var R3Weight: UITextField!
    @IBOutlet weak var R1CoGOffset: UITextField!
    @IBOutlet weak var R2CoGOffset: UITextField!
    @IBOutlet weak var R3CoGOffset: UITextField!
    @IBOutlet weak var AngleLabel: UILabel!
    
    //declaring basic variables and constants for constant values like switch height and switch center of mass height, etc.
    var angle = Float(0.0);
    var R1Position = Float(0.0);
    var R2Position = Float(0.0);
    var R3Position = Float(0.0);
    var generatorSwitchHeight = Float(48.375)
    var generatorSwitchCOMHeight = Float(26.0)
    var generatorSwitchMass = Float(93.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //declaring a list of colors for easy use throughout the program
        let mainColors: [UIColor] = [UIColor.blue, UIColor.orange, UIColor.purple, UIColor.gray]
        
        //setting the colors and initial values of the three robot position sliders
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

    //For each action of moving one of the three sliders, use the transform p = 110v-55 (where v is slider value and p is displayed value)
    // to scale and normalize position and update the label value
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
    
    //This is an action that calls two other method subroutines to update the display view of the app with the sliders 
    // and updates the switch balance angle calculation
    @IBAction func CalculateAngle(_ sender: Any) {
        updateView()
        updateAngle()
    }
    
    //The below method makes sliders visible if they have a value associated with them, otherwise it hides the unused sliders
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
    
    //This method takes into account the robot weight, center of gravity offset, and robot position as well as the switch's physical characteristics
    // to calculate the switch's total angle. The independent variables of this analysis are the Robot Weight, Robot Position, Robot CoG offset, while the
    // constant variables are the Switch Height, Switch Mass, and the Switch Center of Mass Height. 8 degrees is what constitutes a successfully balanced
    // climb onto the switch, which is why the color of the angle turns either red or green based on whether the switch angle is within 8 degrees either side
    // or not.
    // Formula: atan[-(R1Weight*R1Position + R2Weight*R2Position + R3Weight*R3Position)/((R1Weight*(generatorSwitchHeight + R1CoGOffset)) + 
    // (R2Weight*(generatorSwitchHeight + R2CoGOffset)) + (R3Weight*(generatorSwitchHeight + R3CoGOffset)) + (generatorSwitchMass * generatorSwitchCOMHeight)]
    // This formula was calculated using the basic physics of center of gravity and its effects on lever objects in regards to torque with robot forces in different directions
    // It returns in degrees that I subsequently convert to radians through multiplying by 180/pi
    
    @objc func updateAngle() {
        
        //declares variables to be used
        var R1WeightFloat: Float?
        var R1CoGOffsetFloat: Float?
        var R2WeightFloat: Float?
        var R2CoGOffsetFloat: Float?
        var R3WeightFloat: Float?
        var R3CoGOffsetFloat: Float?
        
        //iterates through a while loop to set the variables to inputtable values
        var iteration = 1
        while iteration < 4 {
            if iteration == 1 {
                 R1WeightFloat = Float(R1Weight.text!)
                 R1CoGOffsetFloat = Float(R1CoGOffset.text!)
            }
            else if iteration == 2 {
                R2WeightFloat = Float(R2Weight.text!)
                R2CoGOffsetFloat = Float(R2CoGOffset.text!)
            }
            else if iteration == 3 {
                R3WeightFloat = Float(R3Weight.text!)
                R3CoGOffsetFloat = Float(R3CoGOffset.text!)
            }
            iteration = iteration + 1
        }
        
        
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

