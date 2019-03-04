//
//  MoreLoginViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/16.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit
import IBAnimatable

class MoreLoginViewController: AnimatableModalViewController {
    
    var closeButton: UIButton!
    var titleLabel: UILabel!
    var roundrectView1: UIView!
    var roundrectView2: UIView!
    var mobileTF: UITextField!
    var seperatorView1: UIView!
    var seperatorView2: UIView!
    var sendVertifyButton: UIButton!
    var vertifyTF: UITextField!
    var retrieveButton: UIButton!
    var tipLabel: UILabel!
    var enterButton: UIButton!
    var confirmButton: UIButton!
    var readLabel: UILabel!
    var loginButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        
        ///设置主题
        setTheme()
    }

    func createUI() {
        
        view.backgroundColor = UIColor.white
        
        ///关闭按钮
        closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "icon_popup_close_24x24_"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismissClick(sender:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(-20)
        }
        
        ///标题
        titleLabel = UILabel()
        titleLabel.text = "登录你的头条，精彩永不消失"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(48)
        }
        
        ///圆角打底view1
        roundrectView1 = UIView()
        roundrectView1.backgroundColor = UIColor.white
        roundrectView1.layer.cornerRadius = 22.0
        roundrectView1.layer.masksToBounds = true
        roundrectView1.layer.borderColor = UIColor.lightGray.cgColor
        roundrectView1.layer.borderWidth = 0.8
        self.view.addSubview(roundrectView1)
        roundrectView1.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(44)
        }
        
        ///发送验证码
        sendVertifyButton = UIButton(type: .custom)
        sendVertifyButton.setTitle("发送验证码", for: .normal)
        sendVertifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sendVertifyButton.setTitleColor(UIColor.lightGray, for: .normal)
        roundrectView1.addSubview(sendVertifyButton)
        sendVertifyButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(roundrectView1)
            make.width.equalTo(95)
        }
        
        ///分割线1
        seperatorView1 = UIView()
        seperatorView1.backgroundColor = UIColor.lightGray
        roundrectView1.addSubview(seperatorView1)
        seperatorView1.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(sendVertifyButton.snp.left)
            make.width.equalTo(1)
        }
        
        ///输入手机号
        mobileTF = UITextField()
        mobileTF.placeholder = "手机号"
        mobileTF.clearButtonMode = .whileEditing
        mobileTF.font = UIFont.systemFont(ofSize: 14)
        roundrectView1.addSubview(mobileTF)
        mobileTF.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(roundrectView1)
            make.left.equalTo(12)
            make.right.equalTo(seperatorView1.snp.left)
        }
        
        ///圆角打底view2
        roundrectView2 = UIView()
        roundrectView2.backgroundColor = UIColor.white
        roundrectView2.layer.cornerRadius = 22.0
        roundrectView2.layer.masksToBounds = true
        roundrectView2.layer.borderColor = UIColor.lightGray.cgColor
        roundrectView2.layer.borderWidth = 0.8
        self.view.addSubview(roundrectView2)
        roundrectView2.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(44)
            make.top.equalTo(roundrectView1.snp.bottom).offset(10)
        }
        
        ///找回密码
        retrieveButton = UIButton(type: .custom)
        retrieveButton.setTitle("找回密码", for: .normal)
        retrieveButton.setTitleColor(UIColor.lightGray, for: .normal)
        retrieveButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        retrieveButton.isHidden = true
        roundrectView2.addSubview(retrieveButton)
        retrieveButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(0)
            make.width.equalTo(95)
        }
        
        ///分割线2
        seperatorView2 = UIView()
        seperatorView2.backgroundColor = UIColor.lightGray
        seperatorView2.isHidden = true
        roundrectView2.addSubview(seperatorView2)
        seperatorView2.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(retrieveButton.snp.left)
            make.width.equalTo(1)
        }
        
        ///请输入验证码
        vertifyTF = UITextField()
        vertifyTF.placeholder = "请输入验证码"
        vertifyTF.clearButtonMode = .whileEditing
        vertifyTF.font = UIFont.systemFont(ofSize: 14)
        roundrectView2.addSubview(vertifyTF)
        vertifyTF.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.bottom.equalTo(roundrectView2)
            make.right.equalTo(seperatorView2.snp.left)
        }
        
        ///提示语
        tipLabel = UILabel()
        tipLabel.text = "未注册手机验证后自动登录"
        tipLabel.textColor = UIColor.lightGray
        tipLabel.font = UIFont.systemFont(ofSize: 11)
        tipLabel.textAlignment = .center
        self.view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(roundrectView2.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        ///进入头条
        enterButton = UIButton(type: .custom)
        enterButton.backgroundColor = UIColor(red:0.92, green:0.67, blue:0.67, alpha:1.00)
        enterButton.setTitle("进入头条", for: .normal)
        enterButton.setTitleColor(UIColor.white, for: .normal)
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        enterButton.layer.cornerRadius = 22.0
        enterButton.layer.masksToBounds = true
        self.view.addSubview(enterButton)
        enterButton.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(tipLabel.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        
        ///阅读条款
        readLabel = UILabel()
        readLabel.text = "我已阅读并同意“用户协议和隐私条款”"
        readLabel.textAlignment = .center
        readLabel.font = UIFont.systemFont(ofSize: 11)
        self.view.addSubview(readLabel)
        readLabel.snp.makeConstraints { (make) in
            make.top.equalTo(enterButton.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        ///已阅读
        confirmButton = UIButton(type: .custom)
        confirmButton.setImage(UIImage(named: "details_choose_icon_15x15_"), for: .normal)
        confirmButton.setImage(UIImage(named: "details_choose_ok_icon_15x15_"), for: .selected)
        confirmButton.addTarget(self, action: #selector(readConfirmClick(sender:)), for: .touchUpInside)
        confirmButton.isSelected = true
        self.view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(readLabel.snp.centerY)
            make.right.equalTo(readLabel.snp.left).offset(-5)
        }
        
        ///账号密码登录
        loginButton = UIButton(type: .custom)
        loginButton.setTitle("账号密码登录", for: .normal)
        loginButton.setTitle("免密码登录", for: .selected)
        loginButton.setTitleColor(UIColor.blue, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        loginButton.addTarget(self, action: #selector(switchLoginWay(sender:)), for: .touchUpInside)
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(readLabel.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        ///底部四个按钮
        let images = ["weixin_sdk_login_40x40_","qq_sdk_login_40x40_","tianyi_sdk_login_40x40_","mailbox_sdk_login_40x40_"]
        var index: Int = 0
        let width: CGFloat = (SCREEN_WIDTH - 60) / 4
        
        
        for element in images {
            let button = UIButton(type: .custom)
            button.tag = 1100 + index
            button.setImage(UIImage(named: element), for: .normal)
            self.view.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.bottom.equalTo(-40)
                make.left.equalTo(30 + width * CGFloat(index))
                make.width.equalTo(width)
                
                index += 1
            })
        }
    }
    
    ///设置主题
    func setTheme() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
        tipLabel.theme_textColor = "colors.cellRightTextColor"
        readLabel.theme_textColor = "colors.black"
        enterButton.theme_backgroundColor = "colors.enterToutiaoBackgroundColor"
        enterButton.theme_setTitleColor("colors.enterToutiaoTextColor", forState: .normal)
        confirmButton.theme_setImage("images.loginReadButton", forState: .normal)
        confirmButton.theme_setImage("images.loginReadButtonSelected", forState: .selected)
        roundrectView1.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        roundrectView2.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        closeButton.theme_setImage("images.loginCloseButtonImage", forState: .normal)
        
        let wechatButton: UIButton = self.view.viewWithTag(1100) as! UIButton
        let qqButton: UIButton = self.view.viewWithTag(1101) as! UIButton
        let tianyiButton: UIButton = self.view.viewWithTag(1102) as! UIButton
        let mailButton: UIButton = self.view.viewWithTag(1103) as! UIButton
        wechatButton.theme_setImage("images.moreLoginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.moreLoginQQButton", forState: .normal)
        tianyiButton.theme_setImage("images.moreLoginTianyiButton", forState: .normal)
        mailButton.theme_setImage("images.moreLoginMailButton", forState: .normal)
    }
    
    ///已阅读
    @objc func readConfirmClick(sender: UIButton) {
        confirmButton.isSelected = !sender.isSelected
    }
    
    ///点击消失
    @objc func dismissClick(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    ///切换登录方式
    @objc func switchLoginWay(sender: UIButton) {
        loginButton.isSelected = !sender.isSelected
        titleLabel.text = sender.isSelected ? "账号密码登录" : "登录你的头条，精彩永不消失"
        seperatorView1.isHidden = sender.isSelected
        sendVertifyButton.isHidden = sender.isSelected
        seperatorView2.isHidden = !sender.isSelected
        retrieveButton.isHidden = !sender.isSelected
        tipLabel.isHidden = sender.isSelected
        vertifyTF.placeholder = sender.isSelected ? "密码" : "请输入验证码"
    }

}
