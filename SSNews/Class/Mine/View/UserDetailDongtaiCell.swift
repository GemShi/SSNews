//
//  UserDetailDongtaiCell.swift
//  SSNews
//
//  Created by GemShi on 2018/9/10.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class UserDetailDongtaiCell: UITableViewCell, RegisterCellOrNib {
    
    var seperatorView: UIView!
    var topView: UIView!
    var middleView: UIView!
    var bottomView: UIView!
    var avatarImgView: UIImageView!
    var nameLabel: UILabel!
    var subtitleLabel: UILabel!
    var moreButton: UIButton!
    var readCountLabel: UILabel!
    var likeButton: UIButton!
    var commentButton: UIButton!
    var forwardButton: UIButton!
    
    var dongtaiModel: UserDetailDongtai? {
        didSet {
            avatarImgView.kf.setImage(with: URL(string: dongtaiModel!.user.avatar_url))
            nameLabel.text = dongtaiModel?.user.screen_name
            likeButton.setTitle(dongtaiModel?.diggCount, for: .normal)
            commentButton.setTitle(dongtaiModel?.commentCount, for: .normal)
            forwardButton.setTitle(dongtaiModel?.forwardCount, for: .normal)
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createUI() {
        seperatorView = UIView()
        seperatorView.backgroundColor = UIColor.globalBackgroundColor()
        contentView.addSubview(seperatorView)
        seperatorView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(5)
        }
        
        topView = UIView()
        contentView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(seperatorView.snp.bottom)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(45)
        }
        
        bottomView = UIView()
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(48)
        }
        
        middleView = UIView()
        contentView.addSubview(middleView)
        middleView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        //顶部布局
        avatarImgView = UIImageView()
        avatarImgView.layer.cornerRadius = 15.0
        avatarImgView.layer.masksToBounds = true
        topView.addSubview(avatarImgView)
        avatarImgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(topView.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textColor = .black
        topView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImgView.snp.right).offset(5)
            make.centerY.equalTo(avatarImgView.snp.centerY)
        }
        
        subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = .lightGray
        topView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
        
        moreButton = UIButton(type: .custom)
        moreButton.setImage(UIImage(named: "morebutton_dynamic_14x8_"), for: .normal)
        topView.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(topView.snp.right)
            make.centerY.equalTo(topView.snp.centerY)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        //底部布局
        readCountLabel = UILabel()
        readCountLabel.font = UIFont.systemFont(ofSize: 11)
        readCountLabel.textColor = .lightGray
        bottomView.addSubview(readCountLabel)
        readCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.snp.left).offset(5)
            make.top.equalTo(bottomView.snp.top).offset(5)
        }
        
        likeButton = UIButton(type: .custom)
        likeButton.setImage(UIImage(named: "feed_like_24x24_"), for: .normal)
        likeButton.setImage(UIImage(named: "feed_like_press_24x24_"), for: .selected)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.setTitleColor(.red, for: .selected)
        bottomView.addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.snp.left)
            make.bottom.equalTo(bottomView.snp.bottom)
            make.width.equalTo(SCREEN_WIDTH / 3)
            make.height.equalTo(30)
        }
        
        commentButton = UIButton(type: .custom)
        commentButton.setImage(UIImage(named: "comment_feed_24x24_"), for: .normal)
        commentButton.setTitleColor(.black, for: .normal)
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bottomView.addSubview(commentButton)
        commentButton.snp.makeConstraints { (make) in
            make.left.equalTo(likeButton.snp.right)
            make.centerY.equalTo(likeButton.snp.centerY)
            make.width.equalTo(likeButton.snp.width)
            make.height.equalTo(likeButton.snp.height)
        }
        
        forwardButton = UIButton(type: .custom)
        forwardButton.setImage(UIImage(named: "feed_share_24x24_"), for: .normal)
        forwardButton.setTitleColor(.black, for: .normal)
        forwardButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bottomView.addSubview(forwardButton)
        forwardButton.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.centerY.equalTo(likeButton.snp.centerY)
            make.width.equalTo(likeButton.snp.width)
            make.height.equalTo(likeButton.snp.height)
        }
        
        //中部布局
        
    }
}
