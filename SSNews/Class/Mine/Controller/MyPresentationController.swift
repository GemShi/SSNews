//
//  MyPresentationController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/31.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class MyPresentationController: UIPresentationController {

    var presentFrame: CGRect?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPresentedViewController), name: NSNotification.Name(rawValue: MyPresentationControllerDismiss_NOTI), object: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = presentFrame!
        
        let coverView = UIView(frame: UIScreen.main.bounds)
//        let coverView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200))
        coverView.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedViewController))
        coverView.addGestureRecognizer(tap)
        //在容器视图上添加一个蒙版，插入到展现的视图的下面
        containerView?.insertSubview(coverView, at: 0)
    }
    
    //移除弹出的控制器
    @objc func dismissPresentedViewController() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
