//
//  UserDetailBottomPopController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/31.
//  Copyright © 2018年 GemShi. All rights reserved.
//
//弹出的小视图

import UIKit

class UserDetailBottomPopController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "udPopCellID"
    
    var popImgView: UIImageView!
    var tableView: UITableView!
    var didSelectedChildClosure: ((BottomTabChildren) -> ())?
    var children = [BottomTabChildren]() {
        didSet {
            tableView?.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }

    func createUI() {
        
        popImgView = UIImageView(image: UIImage(named: "popup_118x58_"))
        view.addSubview(popImgView)
        popImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-15)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    ///tableView代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let child = children[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MyPresentationControllerDismiss_NOTI), object: nil)
        didSelectedChildClosure!(children[indexPath.row])
    }

}
