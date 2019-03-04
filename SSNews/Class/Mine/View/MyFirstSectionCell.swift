//
//  MyFirstSectionCell.swift
//  SSNews
//
//  Created by GemShi on 2018/8/13.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

protocol MyFirstSectionCellDelegate: class {
    //点击了cell
    func myFirstSectionCellDidSelected(cell: MyFirstSectionCell, myConcern: MyConcern)
}

class MyFirstSectionCell: UITableViewCell, RegisterCellOrNib {
    
    //声明一个代理指针
    weak var delegate: MyFirstSectionCellDelegate?
    
    var bgView: UIView?
    var collectionView: UICollectionView?
    var leftLabel: UILabel?
    var rightLabel: UILabel?
    var imgView: UIImageView?
    var myConcerns = [MyConcern]() {
        didSet{
            collectionView?.reloadData()
        }
    }
    var myCellModel: MyCellModel? {
        didSet {
            leftLabel?.text = myCellModel?.text
            rightLabel?.text = myCellModel?.grey_text
        }
    }
    var myConcern: MyConcern? {
        didSet{
            
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
    
    func createUI() {
        if bgView == nil {
            bgView = UIView()
            bgView?.backgroundColor = UIColor.white
            contentView.addSubview(bgView!)
            bgView?.snp.makeConstraints({ (make) in
                make.left.top.right.equalTo(0)
                make.height.equalTo(44)
            })
        }
        
        if leftLabel == nil {
            leftLabel = UILabel()
            leftLabel?.font = UIFont.systemFont(ofSize: 15)
            bgView?.addSubview(leftLabel!)
            leftLabel?.snp.makeConstraints({ (make) in
                make.left.equalTo(11)
                make.centerY.equalTo(bgView!.snp.centerY)
            })
        }
        
        if rightLabel == nil {
            rightLabel = UILabel()
            rightLabel?.font = UIFont.systemFont(ofSize: 13)
            rightLabel?.textColor = UIColor.gray
            rightLabel?.textAlignment = .right
            bgView?.addSubview(rightLabel!)
            rightLabel?.snp.makeConstraints({ (make) in
                make.right.equalTo(-30)
                make.centerY.equalTo(bgView!.snp.centerY)
            })
        }
        
        if imgView == nil {
            imgView = UIImageView()
            imgView?.image = UIImage(named: "setting_rightarrow_8x14_")
            bgView?.addSubview(imgView!)
            imgView?.snp.makeConstraints({ (make) in
                make.centerY.equalTo(bgView!.snp.centerY)
                make.left.equalTo(rightLabel!.snp.right).offset(5)
            })
        }
        
        if collectionView == nil {
            let flowLayout = MyConcernFlowLayout()
            collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
            collectionView?.backgroundColor = UIColor.white
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView?.showsVerticalScrollIndicator = false
            collectionView?.showsHorizontalScrollIndicator = false
            collectionView?.ss_regiserCell(cell: MyConcernCell.self)
            contentView.addSubview(collectionView!)
            collectionView?.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView!.snp.bottom)
                make.left.right.bottom.equalTo(0)
            })
        }
    }
    
    func setTheme() {
        leftLabel?.theme_textColor = "colors.black"
        rightLabel?.theme_textColor = "colors.cellRightTextColor"
        imgView?.theme_image = "images.cellRightArrow"
//        lineView?.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        bgView?.theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView?.theme_backgroundColor = "colors.cellBackgroundColor"
    }

}

extension MyFirstSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ss_dequeueReusableCell(indexPath: indexPath) as MyConcernCell
        cell.myConcern = myConcerns[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.myFirstSectionCellDidSelected(cell: self, myConcern: myConcerns[indexPath.item])
    }
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        //每个cell的大小
        itemSize = CGSize(width: 58, height: 74)
        //横向间距
        minimumLineSpacing = 0
        //纵向间距
        minimumInteritemSpacing = 0
        //cell上下左右间距
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //设置水平滚动
        scrollDirection = .horizontal
    }
}


