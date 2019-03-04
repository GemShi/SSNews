//
//  MyOtherCellCell.swift
//  SSNews
//
//  Created by GemShi on 2018/8/13.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit
import SnapKit

class MyOtherCell: UITableViewCell, RegisterCellOrNib {
    
    var leftLabel: UILabel?
    var rightLabel: UILabel?
    var imgView: UIImageView?
    var lineView: UIView?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
        
        setTheme()
    }
    
    func createUI() {
        if leftLabel == nil {
            leftLabel = UILabel()
            leftLabel?.font = UIFont.systemFont(ofSize: 15)
            contentView.addSubview(leftLabel!)
            leftLabel?.snp.makeConstraints({ (make) in
                make.left.equalTo(11)
                make.centerY.equalTo(self.contentView)
            })
            
        }
        
        if rightLabel == nil {
            rightLabel = UILabel()
            rightLabel?.textAlignment = .right
            rightLabel?.textColor = UIColor.gray
            rightLabel?.font = UIFont.systemFont(ofSize: 13)
            contentView.addSubview(rightLabel!)
            rightLabel?.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView)
                make.right.equalTo(-30)
            })
        }

        if imgView == nil {
            imgView = UIImageView()
            imgView?.image = UIImage(named: "setting_rightarrow_8x14_")
            contentView.addSubview(imgView!)
            imgView?.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView)
                make.left.equalTo(rightLabel!.snp.right).offset(5)
            })
        }
        
        if lineView == nil {
            lineView = UIView()
            lineView?.backgroundColor = UIColor.init(r: 245, g: 245, b: 245)
            contentView.addSubview(lineView!)
            lineView?.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalTo(0)
                make.height.equalTo(0.5)
            })
        }
        
    }
    
    func setTheme() {
        leftLabel?.theme_textColor = "colors.black"
        rightLabel?.theme_textColor = "colors.cellRightTextColor"
        imgView?.theme_image = "images.cellRightArrow"
        lineView?.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
}
