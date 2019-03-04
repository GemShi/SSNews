//
//  Constant.swift
//  SSNews
//
//  Created by GemShi on 2018/8/8.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import UIKit

///屏幕宽
let SCREEN_WIDTH = UIScreen.main.bounds.width

///屏幕高
let SCREEN_HEIGHT = UIScreen.main.bounds.height

///是否iPhoneX
let iPhoneX = (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812) ? true : false

///tabBar高度
let TABBAR_HEIGHT: CGFloat = iPhoneX ? 83.0 : 49.0

///tabBar底部高度
let TABBAR_SAFEBOTTOM: CGFloat = iPhoneX ? 34.0 : 0.0

///状态栏高度
let STATUSBAR_HEIGHT: CGFloat = iPhoneX ? 44.0 : 20.0

///导航栏高度
let NAVIGATIONBAR_HEIGHT: CGFloat = iPhoneX ? 88.0 : 64.0


///服务器地址
//let BASE_URL = "https://lf.snssdk.com"
//let BASE_URL = "https://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com"

let device_id: Int = 6096495334
let IID: Int = 5034850950
//let device_id: String = "8800803362"
//let IID: String = "14486549076"

//头部高度
let kMineVC_Header_Height: CGFloat = 260
let kUDVC_Header_Height: CGFloat = 146

let isNight_Key = "isNight_Key"

let MyPresentationControllerDismiss_NOTI = "MyPresentationControllerDismiss"

/// 动态图片的宽高
// 图片的宽高
// 1        SCREEN_WIDTH * 0.5
// 2        (SCREEN_WIDTH - 35) / 2
// 3,4,5-9    (SCREEN_WIDTH - 40) / 3
let image1Width: CGFloat = SCREEN_WIDTH * 0.5
let image2Width: CGFloat = (SCREEN_WIDTH - 35) * 0.5
let image3Width: CGFloat = (SCREEN_WIDTH - 40) / 3

