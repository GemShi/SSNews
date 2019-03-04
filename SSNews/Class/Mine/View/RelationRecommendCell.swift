//
//  RelationRecommendCell.swift
//  SSNews
//
//  Created by GemShi on 2018/9/3.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class RelationRecommendCell: UICollectionViewCell, RegisterCellOrNib {
    
    //控件
    var avatarImgView: UIImageView!
    var vipImgView: UIImageView!
    var nameLabel: UILabel!
    var subtitleLabel: UILabel!
    var concernButton: UIButton!
    var loadingImgView: UIImageView!
    
    //数据
    var userCard: UserCard? {
        didSet {
            nameLabel.text = userCard?.user.info.name
            avatarImgView.kf.setImage(with: URL(string: userCard!.user.info.avatar_url))
            vipImgView.isHidden = (userCard?.user.info.user_auth_info == "") ? true : false
            subtitleLabel.text = userCard?.recommend_reason
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
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
        
        avatarImgView = UIImageView()
        avatarImgView.layer.cornerRadius = 33
        avatarImgView.layer.masksToBounds = true
        contentView.addSubview(avatarImgView)
        avatarImgView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.size.equalTo(CGSize(width: 66, height: 66))
        }
        
        vipImgView = UIImageView()
        contentView.addSubview(vipImgView)
        vipImgView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(avatarImgView)
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(avatarImgView.snp.bottom).offset(5)
            make.height.equalTo(21)
        }
        
        concernButton = UIButton(type: .custom)
        concernButton.backgroundColor = UIColor.init(r: 230, g: 100, b: 95)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitleColor(.white, for: .normal)
        concernButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        concernButton.addBorderStyle(concernButton, cornerRadius: 3.0, borderWidth: 0, borderColor: nil)
        concernButton.addTarget(self, action: #selector(concernButtonClick(sender:)), for: .touchUpInside)
        contentView.addSubview(concernButton)
        concernButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-10)
            make.height.equalTo(30)
        }
        
        subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.bottom.equalTo(concernButton.snp.top).offset(-5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        
        loadingImgView = UIImageView(image: UIImage(named: "loading_12x12_"))
        loadingImgView.isHidden = true
        loadingImgView.isUserInteractionEnabled = true
        concernButton.addSubview(loadingImgView)
        loadingImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(concernButton.snp.centerX)
            make.centerY.equalTo(concernButton.snp.centerY)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
    }
    
    func setTheme() {
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
    }
    
    @objc func concernButtonClick(sender: UIButton) {
        loadingImgView.isHidden = false
        loadingImgView.layer.add(animation, forKey: nil)
        if sender.isSelected {
            NetWorkTool.loadRelationUnfollow(user_id: userCard!.user.info.user_id, completionHandle: { (_) in
                sender.isSelected = !sender.isSelected
                
                self.concernButton.theme_backgroundColor = "colors.globalRedColor"
                self.loadingImgView.layer.removeAllAnimations()
                self.loadingImgView.isHidden = true
            })
        }else{
            NetWorkTool.loadRelationFollow(user_id: userCard!.user.info.user_id, completionHandle: { (_) in
                sender.isSelected = !sender.isSelected
                
                self.concernButton.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                self.loadingImgView.layer.removeAllAnimations()
                self.loadingImgView.isHidden = true
            })
        }
    }
    
    lazy var animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = Double.pi * 2
        animation.duration = 1.5
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
        return animation
    }()
}
