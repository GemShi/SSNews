//
//  NoLoginHeaderView.swift
//  SSNews
//
//  Created by GemShi on 2018/8/15.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit
import SwiftTheme

class NoLoginHeaderView: UIView {
    
    var bgImgView: UIImageView?
    var bottomView: UIView?
    var collectButton: UIButton?
    var historyButton: UIButton?
    var nightButton: UIButton?
    var moreButton: UIButton?
    var closure: (() -> ())?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ///布局UI
        createUI()
        
        ///设置主题
        setTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        if bgImgView == nil {
            bgImgView = UIImageView()
            bgImgView?.isUserInteractionEnabled = true
            bgImgView?.image = UIImage(named: "wallpaper_profile_night")
            self.addSubview(bgImgView!)
            bgImgView?.snp.makeConstraints({ (make) in
                make.left.bottom.right.equalTo(0)
                make.top.equalTo(-STATUSBAR_HEIGHT)
            })
        }
        
        if bottomView == nil {
            bottomView = UIView()
            bottomView?.isUserInteractionEnabled = true
            bottomView?.backgroundColor = UIColor.white
            self.addSubview(bottomView!)
            bottomView?.snp.makeConstraints({ (make) in
                make.left.bottom.right.equalTo(0)
                make.height.equalTo(70)
            })
        }
        
        if collectButton == nil {
            collectButton = UIButton(type: .custom)
            collectButton?.setImage(UIImage(named: "favoriteicon_profile_24x24_"), for: .normal)
            collectButton?.setTitle("收 藏", for: .normal)
            collectButton?.setTitleColor(UIColor.black, for: .normal)
            collectButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            collectButton?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: -25, right: 0)
            collectButton?.imageEdgeInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: -25)
            bottomView?.addSubview(collectButton!)
            collectButton?.snp.makeConstraints({ (make) in
                make.top.left.bottom.equalTo(0)
                make.width.equalTo(SCREEN_WIDTH / 3)
            })
        }
        
        if historyButton == nil {
            historyButton = UIButton(type: .custom)
            historyButton?.setImage(UIImage(named: "history_profile_24x24_"), for: .normal)
            historyButton?.setTitle("历 史", for: .normal)
            historyButton?.setTitleColor(UIColor.black, for: .normal)
            historyButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            historyButton?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: -25, right: 0)
            historyButton?.imageEdgeInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: -25)
            bottomView?.addSubview(historyButton!)
            historyButton?.snp.makeConstraints({ (make) in
                make.center.equalTo(bottomView!)
                make.top.bottom.equalTo(0)
                make.width.equalTo(collectButton!)
            })
        }
        
        if nightButton == nil {
            nightButton = UIButton(type: .custom)
            nightButton?.setImage(UIImage(named: "nighticon_profile_24x24_"), for: .normal)
            nightButton?.setTitle("夜 间", for: .normal)
            nightButton?.setTitleColor(UIColor.black, for: .normal)
            nightButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            nightButton?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: -25, right: 0)
            nightButton?.imageEdgeInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: -25)
            nightButton?.addTarget(self, action: #selector(dayOrNightButtonClicked(sender:)), for: .touchUpInside)
            bottomView?.addSubview(nightButton!)
            nightButton?.snp.makeConstraints({ (make) in
                make.top.right.bottom.equalTo(0)
                make.width.equalTo(collectButton!)
            })
        }
        
        if moreButton == nil {
            moreButton = UIButton(type: .custom)
            moreButton?.backgroundColor = UIColor.black
            moreButton?.setTitle("更多登录方式 >", for: .normal)
            moreButton?.setTitleColor(UIColor.white, for: .normal)
            moreButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            moreButton?.layer.cornerRadius = 14.0
            moreButton?.layer.masksToBounds = true
            moreButton?.addTarget(self, action: #selector(presentMoreLoginClick(sender:)), for: .touchUpInside)
            self.addSubview(moreButton!)
            moreButton?.snp.makeConstraints({ (make) in
                make.bottom.equalTo(bottomView!.snp.top).offset(-20)
                make.centerX.equalTo(bottomView!.snp.centerX)
                make.size.equalTo(CGSize(width: 125, height: 28))
            })
        }
        
        ///创建若干登录按钮
        let loginImgArr = ["cellphoneicon_login_profile_66x66_","weixinicon_login_profile_66x66_","qqicon_login_profile_66x66_","sinaicon_login_profile_66x66_"]
        var index: Int = 0
        let width: CGFloat = SCREEN_WIDTH / 4
        
        for element in loginImgArr {
            let loginButton = UIButton(type: .custom)
            loginButton.setImage(UIImage(named: element), for: .normal)
            loginButton.tag = 1000 + index
            loginButton.addTarget(self, action: #selector(loginClick(loginButton:)), for: .touchUpInside)
            self.addSubview(loginButton)
            loginButton.snp.makeConstraints({ (make) in
                make.bottom.equalTo(moreButton!.snp.top).offset(-25)
                make.width.equalTo(width)
                make.left.equalTo(CGFloat(index) * width)
                
                index += 1
            })
        }
        
        
    }
    
    @objc func loginClick(loginButton: UIButton){
        print(loginButton.tag)
    }
    
    ///点击选择夜间模式
    @objc func dayOrNightButtonClicked(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: isNight_Key)
        
        //切换主题
        MyTheme.switchNight(isToNight: sender.isSelected)
        
        //向tabbar发送通知 改变主题
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: sender.isSelected)
    }
    
    ///弹出更多登录方式
    @objc func presentMoreLoginClick(sender: UIButton) {
        closure?()
    }
    
    ///设置主题
    func setTheme() {
        
        nightButton?.isSelected = UserDefaults.standard.bool(forKey: isNight_Key)
        
        let mobileButton = self.viewWithTag(1000) as! UIButton
        let wechatButton = self.viewWithTag(1001) as! UIButton
        let qqButton = self.viewWithTag(1002) as! UIButton
        let sinaButton = self.viewWithTag(1003) as! UIButton
        
        mobileButton.theme_setImage("images.loginMobileButton", forState: .normal)
        wechatButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaButton.theme_setImage("images.loginSinaButton", forState: .normal)
        
        collectButton?.theme_setImage("images.mineFavoriteButton", forState: .normal)
        historyButton?.theme_setImage("images.mineHistoryButton", forState: .normal)
        nightButton?.theme_setImage("images.dayOrNightButton", forState: .normal)
        nightButton?.setTitle("夜 间", for: .normal)
        nightButton?.setTitle("日 间", for: .selected)
        moreButton?.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreButton?.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        collectButton?.theme_setTitleColor("colors.black", forState: .normal)
        historyButton?.theme_setTitleColor("colors.black", forState: .normal)
        nightButton?.theme_setTitleColor("colors.black", forState: .normal)
        bottomView?.theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
}
