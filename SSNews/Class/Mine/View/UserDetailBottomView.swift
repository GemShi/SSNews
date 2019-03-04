//
//  UserDetailBottomView.swift
//  SSNews
//
//  Created by GemShi on 2018/8/30.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

protocol BottomViewClickDelegate: class {
    func bottomViewClick(button: UIButton, bottomTab: BottomTab)
}

class UserDetailBottomView: UIView {
    
    weak var delegate: BottomViewClickDelegate?
    
    var bottomTabs = [BottomTab]() {
        didSet {
            let buttonWidth = (SCREEN_WIDTH - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            //添加按钮
            for (index, bottomTab) in bottomTabs.enumerated() {
                //按钮
                let button = UIButton()
                button.setTitle(bottomTab.name, for: .normal)
                button.tag = index
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.theme_setTitleColor("colors.black", forState: .normal)
                button.theme_setImage("images.tabbar-options", forState: .normal)
                button.addTarget(self, action: #selector(bottomButtonClick(sender:)), for: .touchUpInside)
                self.addSubview(button)
                button.snp.makeConstraints({ (make) in
                    make.top.equalTo(0)
                    make.left.equalTo(CGFloat(index) * buttonWidth)
                    make.width.equalTo(buttonWidth)
                    make.height.equalTo(height)
                })
                //分割线
                let lineView = UIView()
                lineView.theme_backgroundColor = "colors.separatorViewColor"
                addSubview(lineView)
                lineView.snp.makeConstraints({ (make) in
                    make.left.equalTo(button.snp.right)
                    make.centerY.equalTo(button.snp.centerY)
                    make.size.equalTo(CGSize(width: 0.5, height: 32))
                })
            }
            
        }
    }
    
    @objc func bottomButtonClick(sender: UIButton) {
        delegate?.bottomViewClick(button: sender, bottomTab: bottomTabs[sender.tag])
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
