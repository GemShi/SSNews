//
//  SSTabBar.swift
//  SSNews
//
//  Created by GemShi on 2018/8/7.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class SSTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        theme_tintColor = "colors.tabbarTintColor"
        addSubview(publishButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///懒加载按钮
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type: .custom)
        publishButton.theme_setBackgroundImage("images.publishButtonBackgroundImage", forState: .normal)
        publishButton.theme_setBackgroundImage("images.publishButtonBackgroundSelectedImage", forState: .selected)
//        publishButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
//        publishButton.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        publishButton.sizeToFit()
        return publishButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let width = frame.width
        let height = TABBAR_HEIGHT - TABBAR_SAFEBOTTOM

        publishButton.center = CGPoint(x: width * 0.5, y: height * 0.5 - 7)

        let buttonW: CGFloat = width * 0.2
        let buttonH: CGFloat = CGFloat(height)
        let buttonY: CGFloat = 0

        ///这样写更简练
//        var index = 0
//        for button in subviews {
//            if !button.isKind(of: NSClassFromString("UITabBarButton")!) {continue}
//            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
//            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
//            index += 1
//        }
       
        var index = 0
        for button in subviews {
            let buttonX: CGFloat = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            
            if button.isKind(of: NSClassFromString("UITabBarButton")!){
                button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            }else{
                continue
            }
            index += 1
        }
        
    }
    
}
