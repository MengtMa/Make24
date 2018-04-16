//
//  RoundButton.swift
//  Make24
//
//  Created by Mengtong Ma on 4/13/18.
//  Copyright © 2018 Mengtong_ChengCheng. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }

}
