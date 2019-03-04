//
//  OfflineDownloadCell.swift
//  SSNews
//
//  Created by GemShi on 2018/8/21.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class OfflineDownloadCell: UITableViewCell, RegisterCellOrNib {
    
    var nameLabel: UILabel!
    var rightImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        nameLabel = UILabel()
        nameLabel.text = "测试数据"
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        rightImage = UIImageView(image: UIImage(named: "air_download_option_20x20_"))
        rightImage.isUserInteractionEnabled = true
        self.contentView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }

}
