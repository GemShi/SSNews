//
//  UserDetailBottomPushController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/30.
//  Copyright © 2018年 GemShi. All rights reserved.
//
//跳转过去的viewController，加载h5-url

import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {
    
    var url: String?
    
    //将已隐藏的导航栏显示出来
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebView()
    }

    func loadWebView() {
        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url!)!))
        view.addSubview(webView)
    }

}
