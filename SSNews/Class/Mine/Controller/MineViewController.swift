//
//  MineViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/7.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    let cellID = "mineVC_cell"
    let collectionViewCellID = "myFirstSectionCell"
    
    
    var sections = [[MyCellModel]]()//标准写法 var sections = Array<Array<MyCellModel>>()
    var concerns = [MyConcern]()
    
    fileprivate lazy var headerView: NoLoginHeaderView = {
        let headerView = NoLoginHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 260))
        return headerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    ///设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.globalBackgroundColor()
        
        //MARK: tableView属性设置
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
//        tableView.register(MyOtherCellCell.classForCoder(), forCellReuseIdentifier: cellID)
//        tableView.register(MyFirstSectionCell.classForCoder(), forCellReuseIdentifier: collectionViewCellID)
        tableView.ss_registerCell(cell: MyOtherCell.self)
        tableView.ss_registerCell(cell: MyFirstSectionCell.self)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        
        //MARK: 数据解析
        NetWorkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections

            self.tableView.reloadData()
            
            ///加载 我的关注 的数据
            NetWorkTool.loadMyConcern(completionHandle: { (concerns) in
                self.concerns = concerns
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: .automatic)
            })
        }
        
        ///模态弹出视图
        headerView.closure = {
            let loginVC = MoreLoginViewController()
            loginVC.modalSize = (width: .full, height: .custom(size: Float(SCREEN_HEIGHT - (iPhoneX ? 44 : 20))))
            loginVC.modalPosition = .bottomCenter
            loginVC.cornerRadius = 15.0
            self.present(loginVC, animated: true, completion: nil)
        }

    }
    
}

//MARK: tableView代理方法
extension MineViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        view.backgroundColor = UIColor(r: 247, g: 248, b: 249)
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: collectionViewCellID, for: indexPath) as! MyFirstSectionCell
            let cell = tableView.ss_dequeueReusableCell(indexPath: indexPath) as MyFirstSectionCell
            let section = sections[indexPath.section]
            cell.myCellModel = section[indexPath.row]
            cell.selectionStyle = .none
            if concerns.count == 0 || concerns.count == 1 {
                cell.collectionView?.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
            cell.delegate = self as? MyFirstSectionCellDelegate
            return cell
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyOtherCell
        let cell = tableView.ss_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel?.text = myCellModel.text
        cell.rightLabel?.text = myCellModel.grey_text
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 44 : 114
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 2 {
                ///跳转系统设置界面
                let settingsVC = SettingsViewController()
                self.navigationController?.pushViewController(settingsVC, animated: true)
            }
        }
    }
    
    ///MARK: - 代理方法 头部放大
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMineVC_Header_Height + abs(offsetY)
            let f = totalOffset / kMineVC_Header_Height
            headerView.bgImgView?.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
        }
    }

}

///跳转用户详情界面
extension MineViewController: MyFirstSectionCellDelegate {
    func myFirstSectionCellDidSelected(cell: MyFirstSectionCell, myConcern: MyConcern) {
        let udVC = UserDetailViewController()
        if myConcern.userid != nil {
            udVC.userId = myConcern.userid!
        }
        self.navigationController?.pushViewController(udVC, animated: true)
    }
}


