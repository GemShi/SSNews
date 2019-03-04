//
//  RelationRecommendView.swift
//  SSNews
//
//  Created by GemShi on 2018/9/3.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

class RelationRecommendView: UIView {
    
    //数据
    var dataArray = [UserCard](){
        didSet {
            collectionView.reloadData()
        }
    }
    
    //控件
    let cellID = "RelationRecommend_CollectionCell"
    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    var flowLayout: RelationRecommendFlowLayout!
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        
        titleLabel = UILabel()
        titleLabel.text = "相关推荐"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(15)
        }
        
        flowLayout = RelationRecommendFlowLayout()
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.globalBackgroundColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        collectionView.ss_regiserCell(cell: RelationRecommendCell.self)
        
    }

}

extension RelationRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ss_dequeueReusableCell(indexPath: indexPath) as RelationRecommendCell
        cell.userCard = dataArray[indexPath.item]
        return cell
    }
    
}

class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
    }
}
