//
//  HomeNavigationBar.swift
//  SSNews
//
//  Created by GemShi on 2018/10/27.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class HomeNavigationBar: UIView {
    
    var avaterButton: UIButton!
    var searchButton: UIButton!
    var didSelectAvaterClosure: (()->())?
    var didSelectSearchClosure: (()->())?
    
    //重写frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
        }
    }
    
    //控件的固有属性大小,navigationBar.titleView拉伸至屏幕宽
    //iOS11以后要设置
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createUI() {
        avaterButton = UIButton(type: .custom)
        avaterButton.setImage(UIImage(named: "home_no_login_head"), for: .normal)
        avaterButton.theme_setImage("images.home_no_login_head", forState: .normal)
        avaterButton.theme_setImage("images.home_no_login_head", forState: .highlighted)
        avaterButton.addTarget(self, action: #selector(avaterButtonClicked(sender:)), for: .touchUpInside)
        self.addSubview(avaterButton)
        avaterButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(5)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        searchButton = UIButton(type: .custom)
        searchButton.layer.cornerRadius = 6.0
        searchButton.layer.masksToBounds = true
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: .normal)
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: .highlighted)
        searchButton.setTitle("搜索内容", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        searchButton.backgroundColor = .white
        searchButton.setTitleColor(.lightText, for: .normal)
        searchButton.contentHorizontalAlignment = .left
        searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        searchButton.titleLabel?.lineBreakMode = .byTruncatingTail
        searchButton.theme_backgroundColor = "colors.cellBackgroundColor"
        searchButton.theme_setTitleColor("colors.grayColor150", forState: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonClicked(sender:)), for: .touchUpInside)
        self.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.left.equalTo(avaterButton.snp.right).offset(15)
            make.right.equalTo(self.snp.right).offset(-5)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(30)
        }
        
        NetWorkTool.loadHomeSearchSuggesstInfo { (suggestInfo) in
            self.searchButton.setTitle(suggestInfo, for: .normal)
        }
        
    }
    
    @objc func avaterButtonClicked(sender : UIButton) {
        didSelectAvaterClosure?()
    }

    @objc func searchButtonClicked(sender: UIButton) {
        didSelectSearchClosure?()
    }
}

