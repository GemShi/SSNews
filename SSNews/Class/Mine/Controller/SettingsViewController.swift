//
//  SettingsViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/18.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit
import Kingfisher

class SettingsViewController: UITableViewController {

    ///存储plist文件中的数据
    var sections = [[SettingsModel]]()
    let cellID = "settings_cellID"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        
        tableView.ss_registerCell(cell: SettingsCell.self)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        
        ///加载本地plist数据
        loadLocalData()
        
    }

    ///加载本地plist数据
    func loadLocalData() {
        
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!) as! [Any]
//        for arr in dataArray {
//            let array = arr as! Array<Any>
//            var rows = Array<SettingsModel>()
//            for dict in array {
//                let stModel = SettingsModel.deserialize(from: (dict as? NSDictionary))
//                rows.append(stModel!)
//            }
//            sections.append(rows)
//        }
        
        //flatMap是swift中处理数组的高级函数
        sections = dataArray.flatMap({ section in
            (section as! [Any]).flatMap({ row in
                SettingsModel.deserialize(from: row as? NSDictionary)
            })
        })
        
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(r: 247, g: 248, b: 249)
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section]
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ss_dequeueReusableCell(indexPath: indexPath) as SettingsCell
        let rows = sections[indexPath.section]
        let stModel = rows[indexPath.row]
        cell.stModel = stModel
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: //清理缓存
                ///获取缓存
                calculateDiskCacheSize(cell)
            default: break
            }
            
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 5 {
            return 70
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SettingsCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: //清理缓存
                clearCacheAlertController(cell)
            case 1: //设置字体大小
                setFontAlertController(cell)
            case 3: //非wifi网络流量
                setCellularNetworkFlow(cell)
            case 4: //非wifi网络提醒
                setCellularWarning(cell)
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                //跳转离线下载页面
                let odVC = OfflineDownloadViewController()
                self.navigationController?.pushViewController(odVC, animated: true)
                
            default: break
            }
        default: break
        }
    }

}

extension SettingsViewController {
    ///从沙盒中获取缓存数据的大小
    fileprivate func calculateDiskCacheSize(_ cell: SettingsCell) {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            //转换成M
            let sizeM = Double(size) / 1024.0 / 1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            cell.rightTitleLabel.text = sizeString
        }
    }
    
    ///弹出清理缓存的视图
    fileprivate func clearCacheAlertController(_ cell: SettingsCell) {
        let alert = UIAlertController(title: "确定清除所有缓存？问答草稿，离线下载及图片均会被清空", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            //清除缓存的操作
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            let sizeString = "0.00M"
            cell.rightTitleLabel.text = sizeString
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    ///设置字体大小
    fileprivate func setFontAlertController(_ cell: SettingsCell) {
        let alert = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let smallAction = UIAlertAction(title: "小", style: .default) { (_) in
            cell.rightTitleLabel.text = "小"
        }
        let middleAction = UIAlertAction(title: "中", style: .default) { (_) in
            cell.rightTitleLabel.text = "中"
        }
        let bigAction = UIAlertAction(title: "大", style: .default) { (_) in
            cell.rightTitleLabel.text = "大"
        }
        let largeAction = UIAlertAction(title: "特大", style: .default) { (_) in
            cell.rightTitleLabel.text = "特大"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(smallAction)
        alert.addAction(middleAction)
        alert.addAction(bigAction)
        alert.addAction(largeAction)
        present(alert, animated: true, completion: nil)
    }
    
    ///非Wi-Fi网络流量
    fileprivate func setCellularNetworkFlow(_ cell: SettingsCell) {
        let alert = UIAlertController(title: "非WiFi网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default) { (_) in
            cell.rightTitleLabel.text = "最佳效果(下载大图)"
        }
        let betterAction = UIAlertAction(title: "较省流量（智能下图）", style: .default) { (_) in
            cell.rightTitleLabel.text = "较省流量(智能下图)"
        }
        let ordinaryAction = UIAlertAction(title: "极省流量（不下载图）", style: .default) { (_) in
            cell.rightTitleLabel.text = "极省流量(不下载图)"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(bestAction)
        alert.addAction(betterAction)
        alert.addAction(ordinaryAction)
        present(alert, animated: true, completion: nil)
    }
    
    ///设置非Wi-Fi网络提醒
    fileprivate func setCellularWarning(_ cell: SettingsCell) {
        let alert = UIAlertController(title: "非WiFi网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everytimeAction = UIAlertAction(title: "每次提醒", style: .default) { (_) in
            cell.rightTitleLabel.text = "每次提醒"
        }
        let onlyOnceAction = UIAlertAction(title: "提醒一次", style: .default) { (_) in
            cell.rightTitleLabel.text = "提醒一次"
        }
        alert.addAction(cancelAction)
        alert.addAction(everytimeAction)
        alert.addAction(onlyOnceAction)
        present(alert, animated: true, completion: nil)
    }
}








