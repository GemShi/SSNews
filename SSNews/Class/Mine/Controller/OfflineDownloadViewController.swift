//
//  OfflineDownloadViewController.swift
//  SSNews
//
//  Created by GemShi on 2018/8/21.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class OfflineDownloadViewController: UITableViewController {
    
    //标题数组
    fileprivate var dataArray = Array<HomeNewsTitle>()
    //标题数据表
    fileprivate let newsTitleTable = NewsTitleTabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "离线下载"
        
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.ss_registerCell(cell: OfflineDownloadCell.self)
        
        ///加载网路数据
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        //从数据库中取出左右数据，赋值给标题数据
        dataArray = newsTitleTable.selectAll()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(r: 247, g: 248, b: 249)
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: SCREEN_WIDTH - 20, height: 44))
        label.text = "我的频道"
        label.theme_textColor = "colors.black"
        let lineView = UIView(frame: CGRect(x: 0, y: 43, width: SCREEN_WIDTH, height: 1))
        lineView.theme_backgroundColor = "colors.separatorViewColor"
        view.addSubview(label)
        view.addSubview(lineView)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ss_dequeueReusableCell(indexPath: indexPath) as OfflineDownloadCell
        let model = dataArray[indexPath.row]
        cell.nameLabel.text = model.name
        cell.rightImage.theme_image = model.selected ? "images.air_download_option_press" : "images.air_download_option"
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model = dataArray[indexPath.row]
        model.selected = !model.selected
        let cell = tableView.cellForRow(at: indexPath) as! OfflineDownloadCell
        cell.rightImage.theme_image = model.selected ? "images.air_download_option_press" : "images.air_download_option"
        dataArray[indexPath.row] = model
        newsTitleTable.update(model)
        tableView.reloadRows(at: [indexPath], with: .none)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
