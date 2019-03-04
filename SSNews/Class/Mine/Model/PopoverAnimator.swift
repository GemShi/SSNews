//
//  PopoverAnimator.swift
//  SSNews
//
//  Created by GemShi on 2018/8/31.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    ///展现的视图的大小
    var presentFrame: CGRect?
    
    ///记录当前是否打开关闭
    var isPresent: Bool!
    
    override init() {
        super.init()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let pVC = MyPresentationController(presentedViewController: presented, presenting: presenting)
        pVC.presentFrame = presentFrame
        return pVC
    }
    
    ///展开合并的动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            //展开
            let toView = transitionContext.view(forKey: .to)
            toView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitionContext.containerView.addSubview(toView!)
            //执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView?.transform = .identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }else{
            //关闭
            //拿到关闭的视图
            let fromView = transitionContext.view(forKey: .from)
            //执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                //关闭
                fromView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    ///只要实现了这个方法，系统默认的动画就消失了，所有设置都需要我们自己来实现
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    ///告诉系统谁来负责Modal的消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    ///返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
