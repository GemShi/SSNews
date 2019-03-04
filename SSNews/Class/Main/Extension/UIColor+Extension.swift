//
//  UIColor+Extension.swift
//  SSNews
//
//  Created by GemShi on 2018/8/8.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

extension UIColor{
    //给alpha初始值，在使用的时候会有两个方法，一个带alpha的，一个不带alpha的
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat,alpha: CGFloat = 1.0) {
        //新增方法 比之前的方法性能更好
        self.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    //设置背景色的类方法
    class func globalBackgroundColor() -> UIColor{
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    //灰色132
    class func grayColor132() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    //灰色232
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }
    
    //背景红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 230, g: 100, b: 95)
    }
    
    //背景灰色
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }
    
    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
}
