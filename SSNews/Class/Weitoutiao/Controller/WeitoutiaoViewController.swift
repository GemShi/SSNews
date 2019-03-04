//
//  WeitoutiaoViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/10/27.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class WeitoutiaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension WeitoutiaoViewController{
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        
        if UserDefaults.standard.bool(forKey: isNight_Key) {
            //夜间 替换导航栏
            MyThemeStyle.setNightNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }else{
            //日间
            MyThemeStyle.setDayNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }
        
        //监听日间夜间
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    @objc private func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        if selected {
            MyThemeStyle.setNightNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }else{
            MyThemeStyle.setDayNavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        }
    }
    
    //导航栏右按钮点击
    @objc private func rightBarButtonItemClicked() {
        
    }
}
