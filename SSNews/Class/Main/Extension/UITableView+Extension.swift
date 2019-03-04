//
//  UITableView+Extension.swift
//  SSNews
//
//  Created by GemShi on 2018/8/14.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

extension UITableView {
    
    ///注册cell
    func ss_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        
//        if let nib = T.nib {
//            register(nib, forCellReuseIdentifier: T.identifier)
//        }else{
            register(cell, forCellReuseIdentifier: T.identifier)
//        }
        
    }
    
    ///从缓存池出对已经存在的cell
    func ss_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
