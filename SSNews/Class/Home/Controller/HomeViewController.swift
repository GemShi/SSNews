//
//  HomeViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/7.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //标题数据表
    fileprivate let newsTitleTable = NewsTitleTabel()
    
    //懒加载
    lazy var navigationBar: HomeNavigationBar = {
        let navigationBar = HomeNavigationBar()
        return navigationBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
        
        NetWorkTool.loadOfflineDownloadData { (dataArray) in
            //向数据库中插入数据
            self.newsTitleTable.insert(dataArray)
        }
    }

}

extension HomeViewController {
    //设置UI
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navigationBar
        //点击了头像按钮，[weak self]解决循环引用
        navigationBar.didSelectAvaterClosure = {[weak self] in
            self!.navigationController?.pushViewController(MineViewController(), animated: true)
        }
    }
}
