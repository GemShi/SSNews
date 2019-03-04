//
//  SSNavigationController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/7.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class SSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar.appearance()
//        navigationBar.theme_barTintColor = "colors.cellBackgroundColor"
        navigationBar.theme_tintColor = "colors.navigationBarTintColor"
        
        if UserDefaults.standard.bool(forKey: isNight_Key) {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
        }else{
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        }
        
        ///全局拖拽手势
        initGlobalPan()
        
        //监听日间夜间
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        if selected {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
        }else{
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func navigationBack() {
        popViewController(animated: true)
    }

}

extension SSNavigationController: UIGestureRecognizerDelegate {
    ///全局拖拽手势
    fileprivate func initGlobalPan() {
        //创建pan手势
        let target = interactivePopGestureRecognizer?.delegate
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        globalPan.delegate = self
        view.addGestureRecognizer(globalPan)
        //禁止系统的手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
}
