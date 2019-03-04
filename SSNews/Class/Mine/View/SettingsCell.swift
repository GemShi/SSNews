//
//  SettingsCell.swift
//  SSNews
//
//  Created by GemShi on 2018/8/20.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell, RegisterCellOrNib {
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var rightTitleLabel: UILabel!
    var arrowImg: UIImageView!
    var swit: UISwitch!
    var lineView: UIView!
    
    var stModel: SettingsModel? {
        didSet {
            //可以直接解包stModel!.title，因为已经存在
            titleLabel.text = stModel!.title
            if stModel?.isHiddenSubtitle == true {
                subtitleLabel.isHidden = true
                titleLabel.snp.updateConstraints({ (make) in
                    make.centerY.equalTo(contentView.snp.centerY)
                })
            }else{
                subtitleLabel.isHidden = false
                subtitleLabel.text = stModel!.subtitle
                titleLabel.snp.updateConstraints({ (make) in
                    make.centerY.equalTo(contentView.snp.centerY).offset(-16)
                })
            }
            if stModel?.isHiddenRightTitle == true {
                rightTitleLabel.isHidden = true
            }else{
                rightTitleLabel.isHidden = false
                rightTitleLabel.text = stModel!.rightTitle
            }
            if stModel?.isHiddenRightArraw == true {
                arrowImg.isHidden = true
            }else{
                arrowImg.isHidden = false
            }
            if stModel?.isHiddenSwitch == true {
                swit.isHidden = true
            }else{
                swit.isHidden = false
            }
        }
    }
    
    

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
        
        setTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        rightTitleLabel = UILabel()
        rightTitleLabel.textColor = UIColor.lightGray
        rightTitleLabel.font = UIFont.systemFont(ofSize: 13)
        rightTitleLabel.textAlignment = .right
        self.contentView.addSubview(rightTitleLabel)
        rightTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        arrowImg = UIImageView(image: UIImage(named: "setting_rightarrow_8x14_"))
        self.contentView.addSubview(arrowImg)
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        swit  = UISwitch()
        self.contentView.addSubview(swit)
        swit.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = UIColor.red
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.numberOfLines = 0
        self.contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.right.equalTo(swit.snp.left).offset(-10)
        }
        
        lineView = UIView()
        lineView.backgroundColor = UIColor.init(r: 245, g: 245, b: 245)
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(contentView.snp.bottom)
            make.right.equalTo(0)
            make.height.equalTo(0.8)
        }
    }
    
    func setTheme() {
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        arrowImg.theme_image = "images.cellRightArrow"
        lineView.theme_backgroundColor = "colors.separatorViewColor"
    }

}
