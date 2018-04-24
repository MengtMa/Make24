//
//  PickerViewController.swift
//  Make24
//
//  Created by Mengtong Ma on 4/22/18.
//  Copyright © 2018 Mengtong_ChengCheng. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var numPicker1: UIPickerView!
    
    @IBOutlet weak var numPicker2: UIPickerView!
    
    @IBOutlet weak var numPicker3: UIPickerView!
    
    @IBOutlet weak var numPicker4: UIPickerView!
    
    var num1Selected = "1"
    var num2Selected = "1"
    var num3Selected = "1"
    var num4Selected = "1"
    
    let number = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return number[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return number.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == numPicker1 {
            num1Selected = number[row]
            print("num1: \(num1Selected)")
        }else if pickerView == numPicker2 {
            num2Selected = number[row]
            print("num2: \(num2Selected)")
        }else if pickerView == numPicker3 {
            num3Selected = number[row]
            print("num3: \(num3Selected)")
        }else {
            num4Selected = number[row]
            print("num4: \(num4Selected)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitPressed(_ sender: UIButton) {
        num1 = Double(num1Selected)!
        num2 = Double(num2Selected)!
        num3 = Double(num3Selected)!
        num4 = Double(num4Selected)!
        skipTimes += 1
        attemptTimes = 1
    }
    
    
    @IBAction func cancePressed(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
