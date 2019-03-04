//
//  UserDetailHeaderView.swift
//  SSNews
//
//  Created by GemShi on 2018/8/23.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

let topTabButtonWidth: CGFloat = 80.0
let topTab_Height: CGFloat = 41.0
let topTabIndicatorWidth: CGFloat = 40.0

class UserDetailHeaderView: UIView {
    
    //动态数据数组
    var dongtaiArray = [UserDetailDongtai]() {
        didSet {
            
        }
    }
    
    
    var udModel: UserDetailModel? {
        didSet {
            headerImgView.kf.setImage(with: URL(string: (udModel?.bg_img_url)!))
            avatarImgView.kf.setImage(with: URL(string: (udModel?.avatar_url)!))
            vipImgView.isHidden = udModel!.user_vertified
            nameLabel.text = udModel?.screen_name
            if udModel?.vertified_agency == "" {
                vertifyAgencyLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(nameLabel.snp.bottom)
                })
            } else {
                vertifyAgencyLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(nameLabel.snp.bottom).offset(10)
                })
                vertifyAgencyLabel.text = udModel!.vertified_agency + "："
                vertifyContentLabel.text = udModel!.vertified_content
            }
            
            concernButton.isSelected = udModel!.is_following
            concernButton.theme_backgroundColor = udModel!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" :"colors.userDetailConcernBtnBgColor"
            
            if udModel!.area == "" {
                regionButton.isHidden = true
                regionButton.snp.updateConstraints({ (make) in
                    make.top.equalTo(vertifyAgencyLabel.snp.bottom)
                    make.height.equalTo(0)
                })
            }else{
                regionButton.isHidden = false
                regionButton.snp.updateConstraints({ (make) in
                    make.top.equalTo(vertifyAgencyLabel.snp.bottom).offset(10)
                    make.height.equalTo(20)
                })
                regionButton.setTitle(udModel!.area, for: .normal)
            }
            
            descriptionLabel.text = udModel!.description as String
            let size = udModel!.description.boundingRect(with: CGSize(width: SCREEN_WIDTH - 60, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], context: nil).size
            if size.height > 16 {
                unfoldButton.isHidden = false
            }else{
                unfoldButton.isHidden = true
            }
            
            followersLabel.text = udModel!.followersCount
            followingLabel.text = udModel!.followingsCount
            
            //底部滚动视图
            if udModel!.top_tab.count > 0 {
                topTabScrollView.snp.updateConstraints({ (make) in
                    make.height.equalTo(topTab_Height)
                })
                
                //添加按钮
                for (index, topTab) in udModel!.top_tab.enumerated() {
                    //按钮
                    let button = UIButton()
                    button.tag = index
                    button.setTitle(topTab.show_name, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    button.theme_setTitleColor("colors.black", forState: .normal)
                    button.theme_setTitleColor("colors.globalRedColor", forState: .selected)
                    button.addTarget(self, action: #selector(topTabButtonClick(sender:)), for: .touchUpInside)
                    topTabScrollView.addSubview(button)
                    button.snp.makeConstraints({ (make) in
                        make.top.equalTo(0)
                        make.left.equalTo(CGFloat(index) * topTabButtonWidth)
                        make.width.equalTo(topTabButtonWidth)
                        make.height.equalTo(topTab_Height)
                    })
                    if index == 0 {
                        button.isSelected = true
                        tempButton = button
                    }
                    
                    let tableView = UITableView()
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.rowHeight = 130
                    tableView.showsVerticalScrollIndicator = false
                    tableView.showsHorizontalScrollIndicator = false
                    topTabScrollView.addSubview(tableView)
                    tableView.ss_registerCell(cell: UserDetailDongtaiCell.self)
                }
                
                topTabScrollView.contentSize = CGSize(width: CGFloat(udModel!.top_tab.count) * topTabButtonWidth, height: 0)
                topTabScrollView.addSubview(indicatorView)
            }else{
                topTabScrollView.snp.updateConstraints({ (make) in
                    make.height.equalTo(0)
                })
            }
            
            layoutIfNeeded()
            
            if heightClosure != nil {
                heightClosure!(topTabScrollView.frame.origin.y + topTabScrollView.frame.size.height)
            }
            
        }
        
        
    }
    
    ///topTab指示条
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView(frame: CGRect(x: (topTabButtonWidth - topTabIndicatorWidth) * 0.5, y: topTab_Height - 2, width: topTabIndicatorWidth, height: 2))
        indicatorView.theme_backgroundColor = "colors.globalRedColor"
        return indicatorView
    }()
    
    weak var tempButton = UIButton()
    
    var headerImgView: UIImageView! //头部图片 146 -44
    var bgView: UIView! //头部背景图片
    var avatarImgView: UIImageView! //头像 l-15 72*72
    var vipImgView: UIImageView!    //VIP图标
    var sendMessageButton: UIButton!    //发私信
    var concernButton: UIButton!    //关注
    var recommendButton: UIButton!  //推荐
    var recommendView: UIView!  //相关推荐
    var nameLabel: UILabel! //姓名
    var toutiaohaoImgView: UIImageView! //头条号
    var vertifyAgencyLabel: UILabel!    //头条认证 h-16
    var vertifyContentLabel: UILabel!   //认证内容
    var regionButton: UIButton! //地区
    var descriptionLabel: UILabel!  //描述
    var unfoldButton: UIButton! //展开
    var followingLabel: UILabel!    //关注数量
    var followersLabel: UILabel!    //粉丝数量
    var lineView: UIView!   //分割线
    var topTabScrollView: UIScrollView!   //滚动视图
    var bottomScrollView: UIScrollView!
    
    var heightClosure: ((CGFloat) -> ())?   //刷新高度
    ///自定义推荐view
    lazy var relationRecommendView: RelationRecommendView = {
        let relationRecommendView = RelationRecommendView()
        return relationRecommendView
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        
        setTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        
        //顶部背景
        headerImgView = UIImageView(image: UIImage(named: "wallpaper_profile_night"))
        self.addSubview(headerImgView)
        headerImgView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(kUDVC_Header_Height)
        }
        
        //头部背景图片
        bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(headerImgView.snp.bottom)
            make.height.equalTo(0)
        }
        
        //头像
        avatarImgView = UIImageView()
        avatarImgView.backgroundColor = UIColor.yellow
        avatarImgView.layer.cornerRadius = 36.0
        avatarImgView.layer.masksToBounds = true
        bgView.addSubview(avatarImgView)
        avatarImgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(0)
            make.size.equalTo(CGSize(width: 72, height: 72))
        }
        
        //vip图标
        vipImgView = UIImageView(image: UIImage(named: "all_v_avatar_18x18_"))
        bgView.addSubview(vipImgView)
        vipImgView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(avatarImgView)
        }
        
        //推荐
        recommendButton = UIButton(type: .custom)
        recommendButton.setImage(UIImage(named: "arrow_up_16_16x14_"), for: .normal)
        recommendButton.addBorderStyle(recommendButton, cornerRadius: 3.0, borderWidth: 0.8, borderColor: UIColor.lightGray)
        recommendButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        recommendButton.addTarget(self, action: #selector(recommendClick(sender:)), for: .touchUpInside)
        bgView.addSubview(recommendButton)
        recommendButton.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(28)
            make.width.equalTo(0)
        }
        
        //关注
        concernButton = UIButton()
        concernButton.backgroundColor = UIColor.init(r: 230, g: 100, b: 95)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.setTitleColor(UIColor.white, for: .normal)
        concernButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        concernButton.addBorderStyle(concernButton, cornerRadius: 3.0, borderWidth: 0, borderColor: nil)
        concernButton.addTarget(self, action: #selector(concernClick(sender:)), for: .touchUpInside)
        bgView.addSubview(concernButton)
        concernButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(recommendButton.snp.centerY)
            make.right.equalTo(recommendButton.snp.left).offset(-5)
            make.size.equalTo(CGSize(width: 72, height: 28))
        }
        
        //发私信
        sendMessageButton = UIButton(type: .custom)
        sendMessageButton.setTitle("发私信", for: .normal)
        sendMessageButton.setTitleColor(UIColor.init(r: 72, g: 100, b: 149), for: .normal)
        sendMessageButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendMessageButton.addTarget(self, action: #selector(sendMessageClick(sender:)), for: .touchUpInside)
        bgView.addSubview(sendMessageButton)
        sendMessageButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(concernButton.snp.centerY)
            make.right.equalTo(concernButton.snp.left).offset(-10)
            make.size.equalTo(CGSize(width: 45, height: 28))
        }
        
        //相关推荐 展开折叠
        recommendView = UIView()
        recommendView.backgroundColor = UIColor.globalBackgroundColor()
        bgView.addSubview(recommendView)
        recommendView.snp.makeConstraints { (make) in
            make.top.equalTo(concernButton.snp.bottom).offset(9)
            make.left.right.equalTo(0)
            make.height.equalTo(0)
        }
        
        //名称
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(recommendView.snp.bottom).offset(6)
        }
        
        //头条号
        toutiaohaoImgView = UIImageView(image: UIImage(named: "toutiaohao_34x14_"))
        bgView.addSubview(toutiaohaoImgView)
        toutiaohaoImgView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
        
        //头条认证
        vertifyAgencyLabel = UILabel()
//        vertifyAgencyLabel.text = "头条认证："
        vertifyAgencyLabel.textColor = UIColor.init(r: 230, g: 183, b: 64)
        vertifyAgencyLabel.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(vertifyAgencyLabel)
        vertifyAgencyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(nameLabel.snp.left)
        }
        
        //认证内容
        vertifyContentLabel = UILabel()
//        vertifyContentLabel.text = "何以解忧，唯有暴富"
        vertifyContentLabel.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(vertifyContentLabel)
        vertifyContentLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(vertifyAgencyLabel.snp.centerY)
            make.left.equalTo(vertifyAgencyLabel.snp.right)
        }
        
        //地区 有或没哟
        regionButton = UIButton(type: .custom)
        regionButton.setTitle("北京市 朝阳区", for: .normal)
        regionButton.setImage(UIImage(named: "place_10x12_"), for: .normal)
        regionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        regionButton.setTitleColor(UIColor.black, for: .normal)
        bgView.addSubview(regionButton)
        regionButton.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(vertifyAgencyLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        //描述 一行或多行
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(regionButton.snp.bottom).offset(10)
            make.height.equalTo(16)
        }
        
        //展开折叠按钮
        unfoldButton = UIButton(type: .custom)
        unfoldButton.setTitle("展开", for: .normal)
        unfoldButton.setTitleColor(UIColor.init(r: 72, g: 100, b: 149), for: .normal)
        unfoldButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        unfoldButton.addTarget(self, action: #selector(unfoldClick(sender:)), for: .touchUpInside)
        bgView.addSubview(unfoldButton)
        unfoldButton.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel.snp.right)
            make.right.equalTo(-15)
            make.centerY.equalTo(descriptionLabel.snp.top).offset(8)
            make.size.equalTo(CGSize(width: 30, height: 28))
        }
        
        //关注
        followingLabel = UILabel()
        followingLabel.textColor = UIColor.init(r: 72, g: 100, b: 149)
        followingLabel.font = UIFont.boldSystemFont(ofSize: 15)
        bgView.addSubview(followingLabel)
        followingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        let guanzhuLabel = UILabel()
        guanzhuLabel.text = "关注"
        guanzhuLabel.textColor = UIColor.lightGray
        guanzhuLabel.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(guanzhuLabel)
        guanzhuLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(followingLabel.snp.centerY)
            make.left.equalTo(followingLabel.snp.right).offset(2)
        }
        
        //粉丝
        followersLabel = UILabel()
        followersLabel.textColor = UIColor.init(r: 72, g: 100, b: 149)
        followersLabel.font = UIFont.boldSystemFont(ofSize: 15)
        bgView.addSubview(followersLabel)
        followersLabel.snp.makeConstraints { (make) in
            make.left.equalTo(guanzhuLabel.snp.right).offset(15)
            make.centerY.equalTo(followingLabel.snp.centerY)
        }
        
        let fensiLabel = UILabel()
        fensiLabel.text = "关注"
        fensiLabel.textColor = UIColor.lightGray
        fensiLabel.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(fensiLabel)
        fensiLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(followersLabel.snp.centerY)
            make.left.equalTo(followersLabel.snp.right).offset(2)
        }
        
        //滚动视图
        topTabScrollView = UIScrollView()
        topTabScrollView.backgroundColor = UIColor.white
        topTabScrollView.showsVerticalScrollIndicator = false
        topTabScrollView.showsHorizontalScrollIndicator = false
        bgView.addSubview(topTabScrollView)
        topTabScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(followingLabel.snp.bottom).offset(15)
            make.height.equalTo(topTab_Height)
        }
        
        //分割线
        lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        topTabScrollView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(topTabScrollView.snp.top)
            make.left.equalTo(topTabScrollView.snp.left)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 0.5))
        }
    }
    
    private func resetLayout() {
        bgView.height = topTabScrollView.frame.maxY
        height = bgView.frame.maxY
        
        self.bgView.snp.updateConstraints({ (make) in
            make.height.equalTo(self.topTabScrollView.frame.maxY)
        })
    }
    
    ///点击方法
    @objc func topTabButtonClick(sender: UIButton) {
        tempButton?.isSelected = false
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.25, animations: {
            self.indicatorView.centerX = sender.centerX
        }) { (_) in
            self.tempButton = sender
        }
    }
    
    //描述文字展开折叠
    @objc func unfoldClick(sender: UIButton) {
        unfoldButton.isSelected = !sender.isSelected
        if unfoldButton.isSelected {
            let size = udModel!.description.boundingRect(with: CGSize(width: SCREEN_WIDTH - 60, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], context: nil).size
            sender.setTitle("折叠", for: .normal)
            descriptionLabel.snp.updateConstraints({ (make) in
                make.height.equalTo(ceil(size.height))
            })
        }else{
            sender.setTitle("展开", for: .normal)
            descriptionLabel.snp.updateConstraints({ (make) in
                make.height.equalTo(16)
            })
        }
        
        ///刷新总高度
//        layoutIfNeeded()
//        if heightClosure != nil {
//            heightClosure!(topTabView.frame.origin.y + topTabView.frame.size.height)
//        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }) { _ in
            self.resetLayout()
        }
    }
    
    ///发私信
    @objc func sendMessageClick(sender: UIButton) {
        
    }
    
    ///关注
    @objc func concernClick(sender: UIButton) {
        
        concernButton.theme_backgroundColor = udModel!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" :"colors.userDetailConcernBtnBgColor"
        
        if sender.isSelected {
            //用户已关注 取消关注
            NetWorkTool.loadRelationUnfollow(user_id: udModel!.user_id, completionHandle: { (_) in
                
                sender.isSelected = false
//                sender.setTitle("关注", for: .normal)
                sender.theme_backgroundColor = "colors.globalRedColor"
                
                self.recommendButton.snp.updateConstraints({ (make) in
                    make.width.equalTo(28)
                })
                
            })
        }else{
            //未关注
            NetWorkTool.loadRelationFollow(user_id: udModel!.user_id, completionHandle: { (_) in
                
                sender.isSelected = true
//                sender.setTitle("已关注", for: .normal)
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                
                self.recommendButton.snp.updateConstraints({ (make) in
                    make.width.equalTo(0)
                })
                if self.recommendButton.isSelected == false {
                    self.recommendClick(sender: self.recommendButton)
                }
                
                
            })
        }
        
    }
    
    ///推荐
    @objc func recommendClick(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            recommendView.snp.updateConstraints({ (make) in
                make.height.equalTo(0)
            })
        }else{
            recommendView.snp.updateConstraints({ (make) in
                make.height.equalTo(223)
            })
            
            //点击了关注按钮就会出现相关推荐数据
            NetWorkTool.loadRelationUserRecommend(user_id: self.udModel!.user_id, completionHandle: { (userCards) in
                
                self.recommendView.addSubview(self.relationRecommendView)
                self.relationRecommendView.snp.makeConstraints({ (make) in
                    make.edges.equalTo(self.recommendView.snp.edges)
                })
                self.relationRecommendView.dataArray = userCards
            })
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            //按钮旋转动画
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        }) { (_) in
            self.resetLayout()
        }
        
    }
    
    
    ///设置主题
    func setTheme() {
        theme_backgroundColor = "colors.cellBackgroundColor"
        topTabScrollView.theme_backgroundColor = "colors.cellBackgroundColor"
        lineView.theme_backgroundColor = "colors.separatorViewColor"
        nameLabel.theme_textColor = "colors.black"
        sendMessageButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        followersLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        followingLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        vertifyAgencyLabel.theme_textColor = "colors.vertifiedAgencyTextColor"
        vertifyContentLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        toutiaohaoImgView.theme_image = "images.toutiaohao"
    }
    
}

extension UserDetailHeaderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dongtaiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ss_dequeueReusableCell(indexPath: indexPath) as UserDetailDongtaiCell
        cell.dongtaiModel = dongtaiArray[indexPath.row]
        return cell
    }
    
    
}




