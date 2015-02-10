//
//  ViewController.swift
//  calculator
//
//  Created by Akash Soti on 2/8/15.
//  Copyright (c) 2015 Akash Soti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInMiddleOfTypingANumber{
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "×": performOperation{$0 * $1}
        case "÷": performOperation{$1 / $0}
        case "+": performOperation{$0 + $1}
        case "−": performOperation{$1 - $0}
        case "√": performOperation{sqrt($0)}
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInMiddleOfTypingANumber = false
        }
    }
}

