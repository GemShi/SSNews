//
//  NetworkTool.swift
//  SSNews
//
//  Created by GemShi on 2018/8/10.
//  Copyright © 2018年 GemShi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol NetworkToolProtocol {
    
    //获取用户详情文章列表
    static func loadUserDetailArticleList(user_id: Int, completionHandle: @escaping ((_ articles: [UserDetailDongtai]) -> ()))
    
    //获取用户详情的动态列表数据
    static func loadUserDetailDongtaiList(user_id: Int, completionHandle: @escaping ((_ dongtais: [UserDetailDongtai]) -> ()))
    
    //点击了关注按钮就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id: Int, completionHandle: @escaping (_ concerns: [UserCard]) -> ())
    
    //点击关注按钮，关注用户
    static func loadRelationFollow(user_id: Int, completionHandle: @escaping (_ user: ConcernUser) -> ())
    
    //已关注用户 取消关注
    static func loadRelationUnfollow(user_id: Int, completionHandle: @escaping (_ user: ConcernUser) -> ())
    
    //用户详情数据
    static func loadUserDetailData(user_id: Int, completionHandle: @escaping (_ userDetail: UserDetailModel) -> ())
    
    //首页搜索框接口
    static func loadHomeSearchSuggesstInfo(completionHandle: @escaping ((_ suggestInfo: String) -> ()))
    
    //离线下载界面网络数据
    static func loadOfflineDownloadData(completionHandle: @escaping (_ sections: [HomeNewsTitle]) -> ())
    
    //我的界面cell的数据
    static func loadMyCellData(completionHandle: @escaping (_ sections: [[MyCellModel]]) -> ())
    
    //我的关注数据
    static func loadMyConcern(completionHandle: @escaping (_ concerns: [MyConcern]) -> ())
}

extension NetworkToolProtocol{
    
    //获取用户详情文章列表
    static func loadUserDetailArticleList(user_id: Int, completionHandle: @escaping ((_ articles: [UserDetailDongtai]) -> ())) {
        let url = BASE_URL + "/pgc/ma/?"
        let params = ["user_id": user_id,
                      "page_type": 1,
                      "media_id": user_id,
                      "output": "json",
                      "is_json": 1,
                      "from": "user_profile_app",
                      "version": 2,
                      "as": "A1157A8297BEED7",
        "cp": "59549FCDF1885E1"] as [String: Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络提示错误信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
//                if let data = json["data"].arrayObject {
//                    completionHandle(data.flatMap({
//
//                    }))
//                }
            }
        }
    }
    
    //获取用户详情的动态列表数据
    static func loadUserDetailDongtaiList(user_id: Int, completionHandle: @escaping ((_ dongtais: [UserDetailDongtai]) -> ())) {
        let url = BASE_URL + "/dongtai/list/v15/?"
        let params = ["user_id": user_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络提示错误
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    if let datas = data["data"]?.arrayObject {
                        completionHandle(datas.flatMap({
                            UserDetailDongtai.deserialize(from: $0 as? NSDictionary)
                        }))
                    }
                }
            }
        }
    }
    
    ///点击了关注按钮就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id: Int, completionHandle: @escaping (_ concerns: [UserCard]) -> ()) {
        
        let url = BASE_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["device_id": device_id,
                      "follow_user_id": user_id,
                      "iid": IID,
                      "scene": "follow",
                      "source": "follow"] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络提示错误
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else {
                    return
                }
                if let user_cards = json["user_cards"].arrayObject {
                    completionHandle(user_cards.flatMap({
                        UserCard.deserialize(from: $0 as? NSDictionary)
                    }))
                }
            }
        }
        
    }
    
    ///点击关注按钮，关注用户
    static func loadRelationFollow(user_id: Int, completionHandle: @escaping (_ user: ConcernUser) -> ()) {
        
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络提示错误
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionaryObject {
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandle(user!)
                }
            }
        }
    }
    
    ///已关注用户 取消关注
    static func loadRelationUnfollow(user_id: Int, completionHandle: @escaping (_ user: ConcernUser) -> ()) {
        
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络提示错误
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    if let data = json["data"].dictionaryObject {
                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        SVProgressHUD.setForegroundColor(UIColor.white)
                        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    }
                    return
                }
                if let data = json["data"].dictionaryObject {
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandle(user!)
                }
            }
        }
        
    }
    
    ///用户详情数据
    static func loadUserDetailData(user_id: Int, completionHandle: @escaping (_ userDetail: UserDetailModel) -> ()) {
        
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": IID]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                //网络提示错误
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionaryObject {
                    let userDetail = UserDetailModel.deserialize(from: data as NSDictionary)
                    completionHandle(userDetail!)
                }
            }
        }
    }
    
    ///首页搜索框接口
    static func loadHomeSearchSuggesstInfo(completionHandle: @escaping ((_ suggestInfo: String) -> ())) {
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id" : device_id , "iid" : IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络请求错误提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    completionHandle(data["homepage_search_suggest"]!.string!)
                }
            }
        }
    }
    
    
    ///离线下载界面网络数据
    static func loadOfflineDownloadData(completionHandle: @escaping (_ sections: [HomeNewsTitle]) -> ()) {
        
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": IID]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络请求错误提示信息
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                
                if let dataDict = json["data"].dictionary {
                    
                    if let data = dataDict["data"]?.arrayObject {
                        var resultArray = Array<HomeNewsTitle>()
                        let jsonString = "{\"category\": \"\", \"name\": \"推荐\"}"
                        let recommend = HomeNewsTitle.deserialize(from: jsonString)
                        resultArray.append(recommend!)
                        for item in data {
                            let model = HomeNewsTitle.deserialize(from: item as? NSDictionary)
                            resultArray.append(model!)
                        }
                        completionHandle(resultArray)
                    }
                    
                }
            }
        }
    }
    
    
    //我的界面cell的数据
    static func loadMyCellData(completionHandle: @escaping (_ sections: [[MyCellModel]]) -> ()){
        
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id]
        
        ///Alamofire默认是get请求
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                ///网络请求错误提示信息
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary{
                    if let sections = data["sections"]?.arrayObject {
//                        var sectionArray = [AnyObject]()
//                        for item in sections{
//                            var rows = [MyCellModel]()
//                            for row in item.arrayObject! {
//                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
//                                rows.append(myCellModel!)
//                            }
//                            sectionArray.append(rows as AnyObject)
//                        }
//                        completionHandle(sectionArray as! [[MyCellModel]])
                        
                        completionHandle(sections.flatMap({ item in
                            (item as! [Any]).flatMap({ row in
                                MyCellModel.deserialize(from: row as? NSDictionary)
                            })
                        }))
                        
                    }
                }
            }
            
        }
        
    }
    
    //我的关注数据
    static func loadMyConcern(completionHandle: @escaping (_ concerns: [MyConcern]) -> ()){
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        
        ///Alamofire默认是get请求
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                ///网络请求错误提示信息
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
//                    var concerns = [MyConcern]()
//                    for data in datas {
//                        let myCellModel = MyConcern.deserialize(from: data as? NSDictionary)
//                        concerns.append(myCellModel!)
//                    }
//                    completionHandle(concerns)
                    
                    completionHandle(datas.flatMap({
                        MyConcern.deserialize(from: $0 as? NSDictionary)
                    }))
                }
            }
            
        }
        
    }
}

struct NetWorkTool: NetworkToolProtocol {
    
}
