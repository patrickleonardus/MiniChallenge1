//
//  Button.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 15/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit


@IBDesignable
class Button: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = Colors.orange {
        didSet {
            self.layer.borderColor = (borderColor as! CGColor)
        }
    }
}

