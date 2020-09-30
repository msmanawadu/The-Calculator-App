//
//  ViewController.swift
//  The Calculator App
//
//  Created by Sandeepa Manawadu on 2020/09/29.
//

import UIKit

// enum values for calculator modes
enum modes {
    case notSet
    case addition
    case substraction
    case multiplication
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0" // string version of final answer
    
    var currentMode: modes = .notSet // when calculator loads up, it is in notSet mode
    
    var savedNum: Int = 0 // holds first numeric value entered before any operator button tap
    
    var lastButtonWasOperator: Bool = false // when calculator loads up, no operator button is pressed
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        changeModes(newMode: .substraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    // method where all calculations happens
    @IBAction func didPressEquals(_ sender: Any) {
        
        // make sure that we can convert the labelString to Int
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error"
            return
            // labelInt - holds second numeric value entered after any operator button tap
        }
        
        /* make sure the current mode is an operator mode. If mode is notSet OR last button pressed was a operator button, backout from method*/
        if(currentMode == .notSet || lastButtonWasOperator){
            return
        }
        
        // evaluate the current operator mode
        if(currentMode == .addition){
            savedNum += labelInt
        } else if(currentMode == .substraction) {
            savedNum -= labelInt
        } else {
            savedNum *= labelInt
        }
        
        // reset current operator mode to notSet
        currentMode = .notSet
        
        // update the label with calculated result
        labelString = "\(savedNum)"
        updateText()
        
        /* since the last button tapped was equals (=) button, which is an operator button. This make sure user presses numeric buttons next*/
        lastButtonWasOperator = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        
        // resests calculator's properties, all to defaults
        labelString = "0"
        currentMode = .notSet
        savedNum = 0
        lastButtonWasOperator = false
        
        // reset label text to 0
        label.text = "0"
    }
    
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        
        /* accept the first numeric input sent through the buttons and make sure that there is textual input */
        guard let stringValue: String = sender.titleLabel?.text else {
            label.text = "Error"
            return
            // stringValue - string format of button text
        }
        
        /* second numeric input sent through the buttons, after an operator button tap */
        if (lastButtonWasOperator) {
            // if true, the last button tapped, is no longer an operator button
            lastButtonWasOperator = false
            
            // reset the label string
            labelString = "0"
        }
        
        // append and set the labelString
        labelString = labelString.appending(stringValue)
        
        /* handle possible preceeding 0's issue by, String to Integer type casting */
        updateText()
    }
    
    
    func updateText() {
        
        // make sure that we can convert the labelString to Int
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error"
            return
        }
        
        /* capturing every numeric input, before user presses an operator button */
        if (currentMode == .notSet) {
            savedNum = labelInt
        }
        
        // format numbers with commas
        // create the constant formatter, an object of NumberFormatter
        let formatter: NumberFormatter = NumberFormatter()
        
        //formatter style
        formatter.numberStyle = .decimal
        
        //formatter
        let num: NSNumber = NSNumber(value: labelInt)
        
        // set the formatted label text with commas
        label.text = formatter.string(from: num)
    }
    
    // changes operator modes upon operator button taps
    func changeModes(newMode: modes){
        
        // ignore any operator button taps before any numeric inputs
        if(savedNum == 0){
            return
        }
        
        // if there is numeric inputs, before an operator button tap
        currentMode = newMode
        
        // update that the last button tapped was an operator button
        lastButtonWasOperator = true
    }
}

