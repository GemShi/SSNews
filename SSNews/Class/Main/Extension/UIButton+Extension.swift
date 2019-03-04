//
//  UIButton+Extension.swift
//  SSNews
//
//  Created by GemShi on 2018/8/23.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addBorderStyle(_ target: UIButton, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) {
        if cornerRadius > 0 {
            target.layer.cornerRadius = cornerRadius
            target.layer.masksToBounds = true
        }
        if borderWidth > 0 {
            target.layer.borderWidth = borderWidth
            target.layer.borderColor = borderColor?.cgColor
        }
    }
    
}
