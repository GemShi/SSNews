//
//  MyConcernCell.swift
//  SSNews
//
//  Created by GemShi on 2018/8/14.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit
import Kingfisher

class MyConcernCell: UICollectionViewCell, RegisterCellOrNib {
    
    var avaterImgView: UIImageView?
    var vipImgView: UIImageView?
    var nameLabel: UILabel?
    var tipButton: UIButton?
    var myConcern: MyConcern? {
        didSet{
            avaterImgView?.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel?.text = myConcern?.name
            if let isVertify = myConcern?.is_verify {
                vipImgView?.isHidden = !isVertify
            }
            if let tips = myConcern?.tips {
                tipButton?.isHidden = !tips
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        
        setTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        if avaterImgView == nil {
            avaterImgView = UIImageView()
            avaterImgView?.backgroundColor = UIColor.red
            avaterImgView?.layer.cornerRadius = 20.0
            avaterImgView?.layer.masksToBounds = true
            avaterImgView?.layer.borderWidth = 0.5
            avaterImgView?.layer.borderColor = UIColor.lightGray.cgColor
            contentView.addSubview(avaterImgView!)
            avaterImgView?.snp.makeConstraints({ (make) in
                make.top.equalTo(5)
                make.centerX.equalTo(self.contentView)
                make.size.equalTo(CGSize(width: 40, height: 40))
            })
        }
        
        if vipImgView == nil {
            vipImgView = UIImageView()
            vipImgView?.image = UIImage(named: "all_v_avatar_18x18_")
            contentView.addSubview(vipImgView!)
            vipImgView?.snp.makeConstraints({ (make) in
                make.right.equalTo(-10)
                make.top.equalTo(30)
                make.size.equalTo(CGSize(width: 15, height: 15))
            })
        }
        
        if tipButton == nil {
            tipButton = UIButton()
            tipButton?.backgroundColor = UIColor.red
            tipButton?.layer.cornerRadius = 5.0
            tipButton?.layer.masksToBounds = true
            contentView.addSubview(tipButton!)
            tipButton?.snp.makeConstraints({ (make) in
                make.top.equalTo(5)
                make.right.equalTo(-10)
                make.size.equalTo(CGSize(width: 10, height: 10))
            })
        }
        
        if nameLabel == nil {
            nameLabel = UILabel()
            nameLabel?.font = UIFont.systemFont(ofSize: 12)
            nameLabel?.textAlignment = .center
            contentView.addSubview(nameLabel!)
            nameLabel?.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.contentView)
                make.top.equalTo(avaterImgView!.snp.bottom).offset(5)
                make.width.equalTo(50)
            })
        }
    }
    
    func setTheme() {
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel?.theme_textColor = "colors.black"
    }
    
}
