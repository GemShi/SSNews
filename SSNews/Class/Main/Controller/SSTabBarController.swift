//
//  SSTabBarController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/7.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class SSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///设置tabbar底部文字的颜色
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.init(red: 0.90, green: 0.39, blue: 0.37, alpha: 1.00)

        addChildViewControllers()
        
        ///更换主题的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        if selected {
            //设置为夜间
            for childController in childViewControllers {
                switch childController.title! {
                case "首页":
                    setNightChildController(controller: childController, imageName: "home")
                case "视频":
                    setNightChildController(controller: childController, imageName: "video")
                case "小视频":
                    setNightChildController(controller: childController, imageName: "huoshan")
                case "微头条":
                    setNightChildController(controller: childController, imageName: "weitoutiao")
                default:
                    break
                }
            }
        }else{
            //设置为日间
            for childController in childViewControllers {
                switch childController.title! {
                case "首页":
                    setDayChildController(controller: childController, imageName: "home")
                case "视频":
                    setDayChildController(controller: childController, imageName: "video")
                case "小视频":
                    setDayChildController(controller: childController, imageName: "huoshan")
                case "微头条":
                    setDayChildController(controller: childController, imageName: "weitoutiao")
                default:
                    break
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///设置夜间控制器
    private func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    ///设置日间控制器
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    ///添加子控制器
    private func addChildViewControllers() {
        addChildViewController(HomeViewController(), title: "首页", imageName: "home")
        addChildViewController(VideoViewController(), title: "视频", imageName: "video")
        addChildViewController(WeitoutiaoViewController(), title: "微头条", imageName: "weitoutiao")
        addChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan")
        
        ///通过KVC的方式设置
        setValue(SSTabBar(), forKey: "tabBar")
    }
    
    ///tabbar底部图片文字
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        
        //设置tabbar文字和图片
        if UserDefaults.standard.bool(forKey: isNight_Key) {
            setNightChildController(controller: childController, imageName: imageName)
        }else{
            setDayChildController(controller: childController, imageName: imageName)
        }
        
        childController.title = title
//        childController.tabBarItem.image = UIImage(named: imageName)
//        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        ///设置nav为tabbarController的子控制器，并且nav的根控制器是初始化的控制器
        let navVC = SSNavigationController(rootViewController: childController)
        addChildViewController(navVC)
        
    }
    
    ///移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
