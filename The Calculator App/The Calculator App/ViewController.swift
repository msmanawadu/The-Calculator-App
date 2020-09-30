//
//  ViewController.swift
//  The Calculator App
//
//  Created by Sandeepa Manawadu on 2020/09/29.
//

import UIKit

enum modes {
    case notSet
    case addition
    case substraction
    case multiplication
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = .notSet
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    
    @IBAction func didPressPlus(_ sender: Any) {
        
    }
    
    
    @IBAction func didPressMinus(_ sender: Any) {
        
    }
    
    
    @IBAction func didPressMultiply(_ sender: Any) {
        
    }
    
    
    @IBAction func didPressEquals(_ sender: Any) {
        
    }
    
    
    @IBAction func didPressClear(_ sender: Any) {
        
    }
    
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        //accept the numeric input and make sure that there is textual input
        
        guard let stringValue: String = sender.titleLabel?.text else {
            label.text = "Error"
            return
        }
        
        labelString = labelString.appending(stringValue)
        
        //handle the possible preceeding 0's issue
        updateText()
    }
    
    
    func updateText() {
        //make sure that we can convert the labelString to Int
        
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error"
            return
        }
        
        //set the label text
        label.text = "\(labelInt)"
    }
    
    func changeModes(newMode: modes){
        
    }
    


}

