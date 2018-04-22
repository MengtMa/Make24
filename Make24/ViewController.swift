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
    
    @IBOutlet weak var succeedLabel: UILabel!
    @IBOutlet weak var skipLabel: UILabel!
    
    @IBOutlet weak var slideMenuConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    
    var num1 = "0"
    var num2 = "0"
    var num3 = "0"
    var num4 = "0"
    var expression = ""
    var result = ""
    var currentOperation:Operation = .Null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptLabel.layer.borderWidth = 0.5
        attemptLabel.layer.borderColor = UIColor.black.cgColor
        succeedLabel.layer.borderWidth = 0.5
        succeedLabel.layer.borderColor = UIColor.black.cgColor
        
        skipLabel.layer.borderWidth = 0.5
        skipLabel.layer.borderColor = UIColor.black.cgColor
        
        outputLabel.layer.borderWidth = 0.5
        outputLabel.layer.borderColor = UIColor.black.cgColor
        //first generate random number
        
        generateRandomNumber()
        

        // Do any additional setup after loading the view, typically from a nib.
        
        slideMenuConstraint.constant = -160
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func generateRandomNumber() {
         let randomNum1 = arc4random_uniform(9) + 1
         let randomNum2 = arc4random_uniform(9) + 1
         let randomNum3 = arc4random_uniform(9) + 1
         let randomNum4 = arc4random_uniform(9) + 1
        
        num1 = "\(randomNum1)"
        num2 = "\(randomNum2)"
        num3 = "\(randomNum3)"
        num4 = "\(randomNum4)"
        
        btnNum1.setTitle(num1, for: .normal)
        btnNum2.setTitle(num2, for: .normal)
        btnNum3.setTitle(num3, for: .normal)
        btnNum4.setTitle(num4, for: .normal)
    }
    @IBAction func numberPressed(_ sender: RoundButton) {
        let numChose = sender.tag
        switch numChose {
        case 1:
            expression += num1
            btnNum1.isEnabled = false
        case 2:
            expression += num2
            btnNum2.isEnabled = false
        case 3:
            expression += num3
            btnNum3.isEnabled = false
        case 4:
            expression += num4
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
    }
    
    
}

