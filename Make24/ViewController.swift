//
//  ViewController.swift
//  Make24
//
//  Created by Mengtong Ma on 4/13/18.
//  Copyright © 2018 Mengtong_ChengCheng. All rights reserved.
//

import UIKit
import TTGSnackbar

var num1: Double = 0
var num2: Double = 0
var num3: Double = 0
var num4: Double = 0
var attemptTimes = 1
var succeedTimes = 0
var skipTimes = 0

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var btnNum1: RoundButton!
    @IBOutlet weak var btnNum2: RoundButton!
    @IBOutlet weak var btnNum3: RoundButton!
    @IBOutlet weak var btnNum4: RoundButton!
    
    @IBOutlet weak var btnDone: RoundButton!
    @IBOutlet weak var attemptLabel: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var succeedLabel: UILabel!
    @IBOutlet weak var skipLabel: UILabel!
    
    @IBOutlet weak var slideMenuConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    
    let N:Double = 24

    var expression = ""
    var result = ""
    var timer = Timer()
    var secCount = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptLabel.layer.borderWidth = 0.5
        attemptLabel.layer.borderColor = UIColor.black.cgColor
        attemptLabel.text = String(attemptTimes)
        
        succeedLabel.layer.borderWidth = 0.5
        succeedLabel.layer.borderColor = UIColor.black.cgColor
        succeedLabel.text = String(succeedTimes)
        
        skipLabel.layer.borderWidth = 0.5
        skipLabel.layer.borderColor = UIColor.black.cgColor
        skipLabel.text = String(skipTimes)
        
        timeLable.layer.borderWidth = 0.5
        timeLable.layer.borderColor = UIColor.black.cgColor
        
        outputLabel.layer.borderWidth = 0.5
        outputLabel.layer.borderColor = UIColor.black.cgColor
        //first generate random number
        if num1 == 0 && num2 == 0 && num3 == 0 && num4 == 0 {
            generateRandomNumber()
        }
        assignNumber()
        startTimer()
        

        // Do any additional setup after loading the view, typically from a nib.
        
        slideMenuConstraint.constant = -160
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func generateRandomNumber() {
        while true {
            num1 = Double(arc4random_uniform(9) + 1)
            num2 = Double(arc4random_uniform(9) + 1)
            num3 = Double(arc4random_uniform(9) + 1)
            num4 = Double(arc4random_uniform(9) + 1)
            
            if getSolution(a: num1, b: num2, c: num3, d: num4).isEmpty == false {
                break
            }
        }
        
    }
    
    func assignNumber() {
        btnNum1.isEnabled = true
        btnNum2.isEnabled = true
        btnNum3.isEnabled = true
        btnNum4.isEnabled = true
        btnDone.isEnabled = false
        
        btnNum1.setTitle("\(Int(num1))", for: .normal)
        btnNum2.setTitle("\(Int(num2))", for: .normal)
        btnNum3.setTitle("\(Int(num3))", for: .normal)
        btnNum4.setTitle("\(Int(num4))", for: .normal)
        
        expression = ""
        outputLabel.text = expression
        secCount = 0
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        secCount += 1
        let min = Int(secCount/60)
        let sec = secCount - min*60
        if sec < 10 {
            timeLable.text = "\(min):0\(sec)"
        }else{
            timeLable.text = "\(min):\(sec)"
        }
    }

    @IBAction func numberPressed(_ sender: RoundButton) {
        btnDone.isEnabled = true
        let numChose = sender.tag
        switch numChose {
        case 1:
            expression += "\(Int(num1))"
            btnNum1.isEnabled = false
        case 2:
            expression += "\(Int(num2))"
            btnNum2.isEnabled = false
        case 3:
            expression += "\(Int(num3))"
            btnNum3.isEnabled = false
        case 4:
            expression += "\(Int(num4))"
            btnNum4.isEnabled = false
        default:
            expression += ""
        }
        outputLabel.text = expression
    }
    
    
    @IBAction func addPressed(_ sender: RoundButton) {
        expression += "+"
        outputLabel.text = expression
    }
    
    @IBAction func subtractPressed(_ sender: RoundButton) {
        expression += "-"
        outputLabel.text = expression
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        expression += "×"
        outputLabel.text = expression
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        expression += "÷"
        outputLabel.text = expression
    }
    
    @IBAction func leftPressed(_ sender: RoundButton) {
        expression += "("
        outputLabel.text = expression
    }
    
    @IBAction func rightPressed(_ sender: RoundButton) {
        expression += ")"
        outputLabel.text = expression
    }
    @IBAction func delPressed(_ sender: RoundButton) {
        if expression.isEmpty == false{
            if expression.count == 1 {
                btnDone.isEnabled = false
            }
            let lastChar = expression.last!
            if lastChar >= "1" && lastChar <= "9" {
                let deletedDigit = Double(String(lastChar))
                if btnNum1.isEnabled == false && deletedDigit == num1{
                    btnNum1.isEnabled = true
                }else if btnNum2.isEnabled == false && deletedDigit == num2 {
                    btnNum2.isEnabled = true
                }else if btnNum3.isEnabled == false && deletedDigit == num3 {
                    btnNum3.isEnabled = true
                }else if btnNum4.isEnabled == false && deletedDigit == num4 {
                    btnNum4.isEnabled = true
                }
                
            }
            expression.remove(at: expression.index(before: expression.endIndex))
            outputLabel.text = expression
        }

    }
    
    @IBAction func donePressed(_ sender: RoundButton) {
        
        attemptTimes += 1
        attemptLabel.text = String(attemptTimes)
        
        let isRight = calculateResult()
        if isRight == true {
            createAlert(title: "Succeed!", message: "Bingo! \(expression) = 24", action: "Next Puzzle")
            succeedTimes += 1
            succeedLabel.text = String(succeedTimes)
            attemptTimes = 1
            attemptLabel.text = String(attemptTimes)
        }else {
            let snackbar = TTGSnackbar(message: "Incorrect. Please try again!", duration: .middle)
            snackbar.show()
        }
    }
    
    func calculateResult() -> Bool {
        let postExpression = convertToPostFix(input: expression)
        let result = calculate(input: postExpression)
        return bingo(x: result)
    }
    
    func calculate(input: String) -> Double {
        var stack = Stack<Double>()
        var d1:Double = 0
        var d2:Double = 0
        var d3:Double = 0
        for i in 0..<input.count {
            let ch = Array(input)[i]
            if ch >= "0" && ch <= "9" {
                stack.push(Double(String(ch))!)
            }
            else {
                if stack.isEmpty == false {
                    d2 = stack.pop()!
                }
                if stack.isEmpty == false {
                    d1 = stack.pop()!
                }
                switch ch {
                    case "+":
                        d3 = d1 + d2
                    case "-":
                        d3 = d1 - d2
                    case "×":
                        d3 = d1 * d2
                    default:
                        d3 = d1 / d2
                }
                stack.push(d3)
            }
        }
        return stack.pop()!
    }
    
    
    func convertToPostFix(input: String) -> String {
        var stringBuilder = ""
        var operatorStack = Stack<Character>()
        let length = input.count
        for i in 0..<length {
            let ch = Array(input)[i]
            print("ch: \(ch)")
            if ch >= "0" && ch <= "9" {
                stringBuilder += String(ch)
            }
            //left bracket
            if ch == "(" {
                operatorStack.push(ch)
            }
            //operator
            if isOperator(op: ch) {
                if operatorStack.isEmpty == true {
                    operatorStack.push(ch)
                }
                else {
                    var stackTop = operatorStack.top
                    if priority(ch: ch) > priority(ch: stackTop!) {
                        operatorStack.push(ch)
                    }
                    else {
                        stackTop = operatorStack.pop()
                        stringBuilder += String(stackTop!)
                        operatorStack.push(ch)
                    }
                    
                }
            }
            
            //right bracket
            if ch == ")" {
                var top = operatorStack.pop()
                while top != "(" {
                    stringBuilder += String(top!)
                    top = operatorStack.pop()
                }
            }
            
        }
        while operatorStack.isEmpty == false {
            stringBuilder += String(operatorStack.pop()!)
        }
        //print(stringBuilder)
        return stringBuilder
    }
    
    func priority(ch: Character) -> Int {
        if ch == "+" || ch == "-" {
            return 1
        }
        if ch == "×" || ch == "÷" {
            return 2
        }
        return 0
    }
    
    func isOperator(op: Character) -> Bool {
        return (op == "+") || (op == "-") || (op == "×") || (op == "÷")
    }
    
    
//    @IBAction func MenuBtnPressed(_ sender: UIBarButtonItem) {
//        if isSlideMenuHidden {
//            slideMenuConstraint.constant = 0
//            UIView.animate(withDuration: 0.3, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }else {
//            slideMenuConstraint.constant = -160
//            UIView.animate(withDuration: 0.3, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }
//        isSlideMenuHidden = !isSlideMenuHidden
//        
//    }
    
    @IBAction func clearBtnPressed(_ sender: UIBarButtonItem) {
        expression = ""
        outputLabel.text = expression
        btnNum1.isEnabled = true
        btnNum2.isEnabled = true
        btnNum3.isEnabled = true
        btnNum4.isEnabled = true
        btnDone.isEnabled = false
    }
    
    
    @IBAction func skipBtnPressed(_ sender: UIBarButtonItem) {
        attemptTimes = 1
        attemptLabel.text = String(attemptTimes)
        skipTimes += 1
        skipLabel.text = String(skipTimes)
        generateRandomNumber()
        assignNumber()
    }
    
    @IBAction func showbtnPressed(_ sender: UIBarButtonItem) {
        let result = getSolution(a: num1, b: num2, c: num3, d: num4)
        if result.isEmpty == false {
            createAlert(title: "Solution", message: result, action: "OK")
        } else {
            createAlert(title: "Solution", message: "Sorry, there are actually no solutions!", action: "OK")
        }
        slideMenuConstraint.constant = -160
        isSlideMenuHidden = !isSlideMenuHidden
        attemptTimes = 1
        attemptLabel.text = String(attemptTimes)
        skipTimes += 1
        skipLabel.text = String(skipTimes)
    }
    
    @IBAction func pickNumPressed(_ sender: UIButton) {
        slideMenuConstraint.constant = -160
        isSlideMenuHidden = !isSlideMenuHidden
    }
    
    
    func createAlert(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.generateRandomNumber()
            self.assignNumber()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getSolution(a: Double, b: Double, c: Double, d: Double) -> String {
        var n: [Double] = [a, b, c, d]
        var o: [Character] = ["+", "-", "*", "/"]
        for w in 0...3 {
            for x in 0...3{
                if x == w {
                    continue
                }
                for y in 0...3 {
                    if y == x || y == w {
                        continue
                    }
                    for z in 0...3 {
                        if z == w || z == x || z == y {
                            continue
                        }
                        for i in 0...3 {
                            for j in 0...3 {
                                for k in 0...3 {
                                    let result = eval(a: n[w], b: n[x], c: n[y], d: n[z], x: o[i], y: o[j], z: o[k])
                                    if result.isEmpty == false{
                                        return result
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return ""
    }
    
    func eval(a: Double, b: Double, c: Double, d: Double, x: Character, y: Character, z: Character) -> String {
        if bingo(x: eval(num1: eval(num1: eval(num1: a, operater: x, num2: b), operater: y, num2: c), operater: z, num2: d)){
            return "( ( \(Int(a)) \(x) \(Int(b)) ) \(y) \(Int(c)) ) \(z) \(Int(d))"
        }
        if bingo(x: eval(num1: eval(num1: a, operater: x, num2: eval(num1: b, operater: y, num2: c)), operater: z, num2: d)) {
            return "( \(Int(a)) \(x) ( \(Int(b)) \(y) \(Int(c)) ) ) \(z) \(Int(d))"
        }
        if bingo(x: eval(num1: a, operater: x, num2: eval(num1: eval(num1: b, operater: y, num2: c), operater: z, num2: d))) {
            
            return "\(Int(a)) \(x) ( ( \(Int(b)) \(y) \(Int(c)) ) \(z) \(Int(d)) )"
        }
        if bingo(x: eval(num1: a, operater: x, num2: eval(num1: b, operater: y, num2: eval(num1: c, operater: z, num2: d)))) {
            return "\(Int(a)) \(x) ( \(Int(b)) \(y) ( \(Int(c)) \(z) \(Int(d)) ) )"
        }
        if bingo(x: eval(num1: eval(num1: a, operater: x, num2: b), operater: y, num2: eval(num1: c, operater: z, num2: d))) {
            return "( ( \(Int(a)) \(x) \(Int(b)) ) \(y) ( \(Int(c)) \(z) \(Int(d)) ) )"
        }
        
        return ""
    }
    
    func bingo(x: Double) -> Bool {

        return abs(x - N) < 0.0000001
    }
    
    func eval(num1: Double, operater: Character, num2: Double) -> Double {
        switch operater {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        default:
            return num1 / num2
        }
    }
    
    
    
    
}



