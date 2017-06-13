//
//  testView.swift
//  IsASample
//
//  Created by 毕志锋 on 15/10/26.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class testView: UIView {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBInspectable var borderColor:UIColor  = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat  = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    
}

