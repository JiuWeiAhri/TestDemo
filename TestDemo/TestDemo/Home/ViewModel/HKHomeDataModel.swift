//
//  HKHomeDataModel.swift
//  MarsCar
//
//  Created by AhriLiu on 2020/12/8.
//  Copyright © 2020 TaoChe. All rights reserved.
//

import UIKit

enum HKHomeItemType {
    /// 当月数据
    case monthData
    /// 代办任务
    case task
    /// 常用功能/工具
    case tools
}

/// 首页数据
class HKHomeDataModel: NSObject {
    
     /**< 常用功能 */
    var offenMenu : HKHomeItemModel?
    
    /**< 数据 */
    var dataStatistics : HKHomeItemModel?
    
    /**< 待办任务 */
    var todoTask : HKHomeItemModel?
}


/// 首页分类数据Model
class HKHomeItemModel: NSObject {
    
    /**< 描述 */
    var desc : String = ""
    
    /**< 按钮组件 */
    var buttons : [HKHomeButtonsModel] = []
    
    /**< 是否更多 */
    var hasMore : Bool = false
    
    /**< 首页类别类型 */
    var itemType : HKHomeItemType = .monthData
    
}
/// 首页小Item  Model
class HKHomeButtonsModel: NSObject {
    var code : String  =  ""
    var desc : String =  ""
    var icon : String =  ""
    var itemType : HKHomeItemType = .monthData
}
