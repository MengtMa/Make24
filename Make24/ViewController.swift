//
//  ViewController.swift
//  Make24
//
//  Created by Mengtong Ma on 4/13/18.
//  Copyright © 2018 Mengtong_ChengCheng. All rights reserved.
//

import UIKit

enum Operation:String {
    case Add = "+"
    case Subtract = "-"
    case Multiply = "*"
    case Divide = "/"
    case Null = "Null"
}

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var btnNum1: RoundButton!
    @IBOutlet weak var btnNum2: RoundButton!
    @IBOutlet weak var btnNum3: RoundButton!
    @IBOutlet weak var btnNum4: RoundButton!
    
    @IBOutlet weak var attemptLabel: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var succeedLabel: UILabel!
    @IBOutlet weak var skipLabel: UILabel!
    
    @IBOutlet weak var slideMenuConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    
    var num1 = 0
    var num2 = 0
    var num3 = 0
    var num4 = 0
    var expression = ""
    var result = ""
    var currentOperation:Operation = .Null
    var timer = Timer()
    var secCount = 0
    var haveSolution = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptLabel.layer.borderWidth = 0.5
        attemptLabel.layer.borderColor = UIColor.black.cgColor
        succeedLabel.layer.borderWidth = 0.5
        succeedLabel.layer.borderColor = UIColor.black.cgColor
        
        skipLabel.layer.borderWidth = 0.5
        skipLabel.layer.borderColor = UIColor.black.cgColor
        
        timeLable.layer.borderWidth = 0.5
        timeLable.layer.borderColor = UIColor.black.cgColor
        
        outputLabel.layer.borderWidth = 0.5
        outputLabel.layer.borderColor = UIColor.black.cgColor
        //first generate random number
        
        generateRandomNumber()
        startTimer()
        

        // Do any additional setup after loading the view, typically from a nib.
        
        slideMenuConstraint.constant = -160
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func generateRandomNumber() {
         num1 = Int(arc4random_uniform(9) + 1)
         num2 = Int(arc4random_uniform(9) + 1)
         num3 = Int(arc4random_uniform(9) + 1)
         num4 = Int(arc4random_uniform(9) + 1)
        
        btnNum1.setTitle("\(num1)", for: .normal)
        btnNum2.setTitle("\(num2)", for: .normal)
        btnNum3.setTitle("\(num3)", for: .normal)
        btnNum4.setTitle("\(num4)", for: .normal)
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
        let numChose = sender.tag
        switch numChose {
        case 1:
            expression += "\(num1)"
            btnNum1.isEnabled = false
        case 2:
            expression += "\(num2)"
            btnNum2.isEnabled = false
        case 3:
            expression += "\(num3)"
            btnNum3.isEnabled = false
        case 4:
            expression += "\(num4)"
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
            let lastChar = expression.last!
            if lastChar >= "1" && lastChar <= "9" {
                let deletedDigit = Int(String(lastChar))
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
    }
    
    @IBAction func MenuBtnPressed(_ sender: UIBarButtonItem) {
        if isSlideMenuHidden {
            slideMenuConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else {
            slideMenuConstraint.constant = -160
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden
        
    }
    
    @IBAction func clearBtnPressed(_ sender: UIBarButtonItem) {
        expression = ""
        outputLabel.text = expression
        btnNum1.isEnabled = true
        btnNum2.isEnabled = true
        btnNum3.isEnabled = true
        btnNum4.isEnabled = true
    }
    
    
    @IBAction func skipBtnPressed(_ sender: UIBarButtonItem) {
        generateRandomNumber()
        secCount = 0
    }
    
    @IBAction func showbtnPressed(_ sender: UIButton) {
        if haveSolution {
            createAlert(message: "equation")
        } else {
            createAlert(message: "Sorry, there are actually no solutions")
        }
    }
    
    func createAlert(message: String) {
        let alert = UIAlertController(title: "Solution", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    
}

