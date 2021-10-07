//
//  ViewController.swift
//  Calculator
//
//  Created by Sin on 2021-07-19.
//  Copyright © 2021 Sin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func addCharToDisplay(str:String){
        if displayTF.text == "0" && (str != "+" && str != "-" && str != "x" && str != "/") {
            displayTF.text = str
        }
        else {
            var newDisplay:String
            if let display = displayTF.text{
                newDisplay = display + str
            }
            else {
                newDisplay = str
            }
            displayTF.text = newDisplay
        }
    }
    
    func removeLastCharIfIsOperator() {
        if let display = displayTF.text {
            if display.last == "+" || display.last == "-" || display.last == "x" || display.last == "/" {
                var newDisplay = display
                newDisplay.remove(at: newDisplay.index(before: newDisplay.endIndex))
                displayTF.text = newDisplay
            }
        }
    }

    @IBAction func btn0(_ sender: Any) {
        addCharToDisplay(str: "0")
    }
    
    @IBAction func btn1(_ sender: Any) {
        addCharToDisplay(str: "1")
    }
    
    @IBAction func btn2(_ sender: Any) {
        addCharToDisplay(str: "2")
    }
    
    @IBAction func btn3(_ sender: Any) {
        addCharToDisplay(str: "3")
    }
    
    @IBAction func btn4(_ sender: Any) {
        addCharToDisplay(str: "4")
    }
    
    @IBAction func btn5(_ sender: Any) {
        addCharToDisplay(str: "5")
    }
    
    @IBAction func btn6(_ sender: Any) {
        addCharToDisplay(str: "6")
    }
    
    @IBAction func btn7(_ sender: Any) {
        addCharToDisplay(str: "7")
    }
    
    @IBAction func btn8(_ sender: Any) {
        addCharToDisplay(str: "8")
    }
    
    @IBAction func btn9(_ sender: Any) {
        addCharToDisplay(str: "9")
    }
    
    
    @IBAction func btnAdd(_ sender: Any) {
        removeLastCharIfIsOperator()
        addCharToDisplay(str: "+")
    }
    
    @IBAction func btnSub(_ sender: Any) {
        removeLastCharIfIsOperator()
        addCharToDisplay(str: "-")
    }
    
    @IBAction func btnMul(_ sender: Any) {
        removeLastCharIfIsOperator()
        addCharToDisplay(str: "x")
    }
    
    @IBAction func btnDiv(_ sender: Any) {
        removeLastCharIfIsOperator()
        addCharToDisplay(str: "/")
    }
    
    func multiplyFromString(str1:String, str2:String)->String? {
        var answer:String?
        if let nb1 = Int(str1) {
            if let nb2 = Int(str2) {
                answer = String(nb1 * nb2)
            }
        }
        return answer
    }
    
    func divideFromString(str1:String, str2:String)->String? {
        var answer:String?
        if let nb1 = Int(str1) {
            if let nb2 = Int(str2) {
                answer = String(nb1 / nb2)
            }
        }
        return answer
    }
    
    func addFromString(str1:String, str2:String)->String? {
        var answer:String?
        if let nb1 = Int(str1) {
            if let nb2 = Int(str2) {
                answer = String(nb1 + nb2)
            }
        }
        return answer
    }
    
    func substractFromString(str1:String, str2:String)->String? {
        var answer:String?
        if let nb1 = Int(str1) {
            if let nb2 = Int(str2) {
                answer = String(nb1 - nb2)
            }
        }
        return answer
    }
    
    func applyChangeToOperationArray(operation:[String], answer:String, middlePos:Int)->[String] {
        var operationCopy = operation
        
        operationCopy[middlePos - 1] = answer
        operationCopy.remove(at: middlePos + 1)
        operationCopy.remove(at: middlePos)
        
        return operationCopy
    }
    
    func calculateOperation(operation:[String])->[String] {
        let firstPosOfMul = operation.firstIndex(of: "x")
        let firstPosOfDiv = operation.firstIndex(of: "/")
        let firstPosOfAdd = operation.firstIndex(of: "+")
        let firstPosOfSub = operation.firstIndex(of: "-")
        
        if let posMul = firstPosOfMul {
            if let posDiv = firstPosOfDiv {
                if posMul < posDiv {
                    if let answer = multiplyFromString(str1: operation[posMul - 1], str2: operation[posMul + 1]) {
                        return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posMul))
                    }
                }
                else {
                    if let answer = divideFromString(str1: operation[posDiv - 1], str2: operation[posDiv + 1]) {
                        return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posDiv))
                    }
                }
            }
            else {
                if let answer = multiplyFromString(str1: operation[posMul - 1], str2: operation[posMul + 1]) {
                    return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posMul))
                }
            }
        }
        else if let posDiv = firstPosOfDiv {
            if let answer = divideFromString(str1: operation[posDiv - 1], str2: operation[posDiv + 1]) {
                return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posDiv))
            }
        }
        else if let posAdd = firstPosOfAdd {
            if let posSub = firstPosOfSub {
                if posAdd < posSub {
                    if let answer = addFromString(str1: operation[posAdd - 1], str2: operation[posAdd + 1]) {
                        return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posAdd))
                    }
                }
                else {
                    if let answer = substractFromString(str1: operation[posSub - 1], str2: operation[posSub + 1]) {
                        return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posSub))
                    }
                }
            }
            else{
                if let answer = addFromString(str1: operation[posAdd - 1], str2: operation[posAdd + 1]) {
                    return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posAdd))
                }
            }
        }
        else if let posSub = firstPosOfSub {
            if let answer = substractFromString(str1: operation[posSub - 1], str2: operation[posSub + 1]) {
                return calculateOperation(operation: applyChangeToOperationArray(operation: operation, answer: answer, middlePos: posSub))
            }
        }
        else {
            return operation
        }
        return operation
    }
    
    @IBAction func btnEqual(_ sender: Any) {
        removeLastCharIfIsOperator()
        if let operation = displayTF.text {
            let parts = operation.components(separatedBy: CharacterSet(charactersIn: "+-x/"))
            
            var i = 0
            var operationArray = [String]()
            for part in parts{
                operationArray.append(part)
                
                let substr = operation.suffix(operation.count - i)
                if let partRange = substr.range(of: part) {
                    i = substr.distance(from: substr.startIndex, to: partRange.upperBound)
                    let desiredPos = partRange.upperBound
                    if desiredPos != substr.endIndex {
                        let operatorString = String(substr[desiredPos])
                        operationArray.append(operatorString)
                    }
                }
            }
            
            displayTF.text = calculateOperation(operation: operationArray)[0] //calculate operation will always return a string array of one element to displayTF
        }
    }
    
    
    @IBAction func btnAC(_ sender: Any) {
        displayTF.text = "0"
    }
}

