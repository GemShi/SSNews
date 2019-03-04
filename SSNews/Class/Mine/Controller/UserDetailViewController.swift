//
//  UserDetailViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/23.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var userId: Int = 0
    var userDetail: UserDetailModel?
    var scrollView: UIScrollView!
    
    ///改变状态栏的字体颜色
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        createLayout()
        
        self.view.addSubview(navigationBar)
        navigationBar.goBackClicked = {
            self.navigationController?.popViewController(animated: true)
        }
        
        loadData()
        
        let testButton = UIButton(frame: CGRect(x: 100, y: SCREEN_HEIGHT - 200, width: 30, height: 30))
        testButton.backgroundColor = .red
        testButton.addTarget(self, action: #selector(testMethod(button:)), for: .touchUpInside)
        self.view.addSubview(testButton)
        
    }
    
    @objc func testMethod(button: UIButton) {
        //弹出子视图
        let udpopVC = UserDetailBottomPopController()
        //⚠️设置模态视图模式
        udpopVC.modalPresentationStyle = .custom
        
        var children = BottomTabChildren()
        children.name = "ceshi"
        children.type = "ceshi"
        children.value = "ceshi"
        children.scheme_href = ""
        
        udpopVC.children = [children]
        
        let count: Int = 1
        button.tag = 0
        
        let animator = PopoverAnimator()
        //转化frame
//        let rect = myBottomView.convert(button.frame, to: view)
        let popWidth = (SCREEN_WIDTH - CGFloat(count + 1) * 20) / CGFloat(count)
        let popX = CGFloat(button.tag) * (popWidth + 20) + 20
        let popHeight = CFloat(count) * 40 + 25
        animator.presentFrame = CGRect(x: popX, y: SCREEN_HEIGHT - 300, width: popWidth, height: CGFloat(popHeight))
        
        
        //⚠️设置跳转代理
        udpopVC.transitioningDelegate = animator
        
        present(udpopVC, animated: true, completion: nil)
    }
    
    ///设置导航栏隐藏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    ///设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    ///懒加载-头视图
    fileprivate lazy var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView()
        return headerView
    }()
    
    ///懒加载-底部视图
    fileprivate lazy var myBottomView: UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - TABBAR_HEIGHT, width: SCREEN_WIDTH, height: TABBAR_HEIGHT))
        myBottomView.delegate = self
        return myBottomView
    }()
    
    ///懒加载-导航栏
    fileprivate lazy var navigationBar: NavigationBarView = {
        let navigationBar = NavigationBarView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: NAVIGATIONBAR_HEIGHT))
        return navigationBar
    }()
    
    ///数据加载
    func loadData() {
        NetWorkTool.loadUserDetailData(user_id: userId) { (udModel) in
            
            NetWorkTool.loadUserDetailDongtaiList(user_id: self.userId, completionHandle: { (udDongtais) in
                self.userDetail = udModel
                self.headerView.udModel = udModel
                self.headerView.dongtaiArray = udDongtais
                if udModel.bottom_tab.count == 0 {
                    
                }else{
                    //添加上
                    self.view.addSubview(self.myBottomView)
                    self.myBottomView.bottomTabs = udModel.bottom_tab
                }
            })
            
        }
    }

    func createLayout() {
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.yellow
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: 0, height: 1000)
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        scrollView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(-STATUSBAR_HEIGHT)
            make.left.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(kUDVC_Header_Height)
        }
        headerView.heightClosure = {(height) -> () in
            self.headerView.snp.updateConstraints { (make) in
                make.height.equalTo(height + kUDVC_Header_Height)
            }
            self.headerView.bgView.snp.updateConstraints({ (make) in
                make.height.equalTo(height)
            })
        }
    }

}

///MARK: - 底部点击代理方法
extension UserDetailViewController: BottomViewClickDelegate {
    //底部按钮的点击
    func bottomViewClick(button: UIButton, bottomTab: BottomTab) {
        
        let udbpVC = UserDetailBottomPushController()
        udbpVC.navigationItem.title = "网页浏览"
        
        if bottomTab.children.count == 0 {
            //直接跳转到下一控制器
            udbpVC.url = bottomTab.value
            navigationController?.pushViewController(udbpVC, animated: true)
        }else{
            //弹出子视图
            let udpopVC = UserDetailBottomPopController()
            //⚠️设置模态视图模式
            udpopVC.modalPresentationStyle = .custom
            
            udpopVC.children = bottomTab.children
            udpopVC.didSelectedChildClosure = {
                udbpVC.url = $0.value
                self.navigationController?.pushViewController(udbpVC, animated: true)
            }
            
            let animator = PopoverAnimator()
            //转化frame
            let rect = myBottomView.convert(button.frame, to: view)
            let popWidth = (SCREEN_WIDTH - CGFloat(userDetail!.bottom_tab.count + 1) * 20) / CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CFloat(bottomTab.children.count) * 40 + 25
            animator.presentFrame = CGRect(x: popX, y: rect.origin.y, width: popWidth, height: CGFloat(popHeight))
            
            //⚠️设置跳转代理
            udpopVC.transitioningDelegate = animator
            
            present(udpopVC, animated: true, completion: nil)
        }
    }
}

///头图下拉放大 + 导航栏渐变
extension UserDetailViewController {
    ///scrollView代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < -44 {
            let totalOffset = kUDVC_Header_Height + abs(offsetY)
            let f = totalOffset / kUDVC_Header_Height
            headerView.headerImgView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        }else{
            var alpha: CGFloat = (offsetY + 44) / 58
            alpha = min(alpha, 1.0)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                changeStatusBarStyle = .default
                navigationBar.leftButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationBar.rightButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            }else{
                changeStatusBarStyle = .lightContent
                navigationBar.leftButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationBar.rightButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
            
            ///标题渐变展示 14 + 15 + 14
            var alpha1: CGFloat = offsetY / 57
            if offsetY >= 0 {
                alpha1 = min(alpha1, 1.0)
                navigationBar.titleLabel.isHidden = false
                navigationBar.titleLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
            }else{
                alpha1 = min(0.0, alpha1)
                navigationBar.titleLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
            }
            
        }
    }
}
