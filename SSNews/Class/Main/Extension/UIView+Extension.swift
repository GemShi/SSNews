//
//  UIView+Extension.swift
//  SSNews
//
//  Created by GemShi on 2018/8/14.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib {
    
}

extension RegisterCellOrNib{
    
    static var identifier: String {
        return "\(self)"
    }
    
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
}

extension UIView {
    ///x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    ///y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    ///width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    ///height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    ///centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    ///centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
}
