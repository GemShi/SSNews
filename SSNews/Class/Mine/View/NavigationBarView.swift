//
//  NavigationBarView.swift
//  SSNews
//
//  Created by GemShi on 2018/8/31.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {
    
    var topView: UIView!
    var bottomView: UIView!
    var leftButton: UIButton!
    var rightButton: UIButton!
    var titleLabel: UILabel! {
        didSet {
//            titleLabel.text
        }
    }
    var goBackClicked: (() -> ())?
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        
        self.backgroundColor = UIColor.clear
        
        topView = UIView()
        topView.backgroundColor = .clear
        self.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(self.snp.centerY)
        }
        
        bottomView = UIView()
        bottomView.backgroundColor = .clear
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.top.equalTo(self.snp.centerY)
        }
        
        leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "personal_home_back_white_24x24_"), for: .normal)
        leftButton.addTarget(self, action: #selector(leftClick(sender:)), for: .touchUpInside)
        bottomView.addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(bottomView.snp.centerY)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "new_morewhite_titlebar_press_22x22_"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightClick(sender:)), for: .touchUpInside)
        bottomView.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(leftButton.snp.centerY)
            make.size.equalTo(leftButton.snp.size)
        }
        
        titleLabel = UILabel()
        titleLabel.text = "标题标题"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.isHidden = true
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView.snp.centerX)
            make.centerY.equalTo(leftButton.snp.centerY)
        }
    }
    
    ///左按钮点击
    @objc func leftClick(sender: UIButton) {
        goBackClicked!()
    }

    ///右按钮点击
    @objc func rightClick(sender: UIButton) {
        
    }
}
