//
//  ViewController.swift
//  Calculator
//
//  Created by Sumeet  Jain on 27/12/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    var doubleValueString = ""
    var expressionString: String = ""
    var startNew = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteNumber))
        rightSwipeGesture.direction = .right
        displayLabel.addGestureRecognizer(rightSwipeGesture)
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteNumber))
        leftSwipeGesture.direction = .left
        displayLabel.addGestureRecognizer(leftSwipeGesture)
        displayLabel.isUserInteractionEnabled = true
    }
    @IBAction func btnAction(_ sender: UIButton) {
        
        if let buttonAction = sender.currentTitle{
            switch buttonAction {
                
            case "AC":
                // Initializing everything to starting phase
                displayLabel.text = "0"
                doubleValueString = ""
                expressionString = ""
                startNew = false
                
            case "=":
                if displayLabel.text != "0"{
                    evaluateExpression(action: buttonAction)
                    checkForLastOperator()
                    let result = NSExpression(format: expressionString)
                    if let resultValue = result.expressionValue(with: nil, context: nil) as? NSNumber{
                        let value = resultValue.doubleValue
                        displayLabel.text = value.displayString
                        expressionString = ""
                        startNew = true
                    }
                }
                
            case "+/-":
                if let firstOp = displayLabel.getLabelText().first {
                    if Int(String(firstOp)) != nil{
                        displayLabel.text = "-" + displayLabel.getLabelText()
                    }else if Int(String(firstOp)) == nil && firstOp == "-"{
                        _ = displayLabel.text?.removeFirst()
                    }
                }
                
            default:
                if displayLabel.text == "0" && Int(buttonAction) != nil{
                    displayLabel.text = buttonAction
                    doubleValueString += buttonAction
                }else{
                    if buttonAction == "x"{
                        evaluateExpression(action: "*")
                    }else if buttonAction == "÷"{
                        evaluateExpression(action: "/")
                    }else{
                        if Int(buttonAction) != nil{
                            doubleValueString += buttonAction
                        }else{
                            evaluateExpression(action: buttonAction)
                        }
                    }
                    displayLabel.text = startNew ? buttonAction : displayLabel.getLabelText() + buttonAction
                    startNew = false
                }
            }
        }
    }
    
    //Converting numbers to double to get precise data from NSExpression
    func evaluateExpression(action: String){
        if startNew{
            doubleValueString = displayLabel.getLabelText()
            startNew = false
        }
        if let doubleValue = doubleValueString.getDouble{
            if action != "="{
                expressionString += String(doubleValue) + action
            }else{
                expressionString += String(doubleValue)
            }
            doubleValueString = ""
        }
    }
    
    //Removing last operand if present, to avoid NSInvalidArgumentException
    func checkForLastOperator(){
        if let lastChar = expressionString.last, Int(String(lastChar)) == nil {
            _ = expressionString.removeLast()
        }
    }
    
    @objc func deleteNumber(){
        var displayText = displayLabel.getLabelText()
        if displayText != "0"{
            if displayText.count == 1{
                displayLabel.text = "0"
            }else{
                _ = displayText.removeLast()
                displayLabel.text = displayText
            }
        }
    }
    
    
}

