//
//  SettingsModel.swift
//  SSNews
//
//  Created by GemShi on 2018/8/18.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingsModel: HandyJSON {
    
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArraw: Bool = false
    
}
