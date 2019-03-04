//
//  UICollectionView+Extension.swift
//  SSNews
//
//  Created by GemShi on 2018/8/14.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func ss_regiserCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellOrNib {
//        if let nib = T.nib {
//            register(nib, forCellWithReuseIdentifier: T.identifier)
//        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
//        }
    }
    
    func ss_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
