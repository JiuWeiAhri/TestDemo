//
//  ViewController.swift
//  TestDemo
//
//  Created by AhriLiu on 2020/12/8.
//  Copyright © 2020 AhriLiu. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell
import Masonry
import YXKitOC
import YXChainTool

class ViewController: UIViewController {
    
    var dataArr = [HKHomeItemModel]()
    private var heightAtIndexPathDic : [String :Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .brown
        
        configUI()
        
        achieveData()
        
    }
    
    // MARK: - Data
    func achieveData() {
        
        let itemModel = HKHomeButtonsModel.init()
        itemModel.desc = "新增工单"
        itemModel.code = "934"
        
        let model1 = HKHomeItemModel.init()
        model1.desc = "当月数据"
        model1.buttons = [itemModel,itemModel,itemModel]
        model1.itemType = .monthData
        
        let model2 = HKHomeItemModel.init()
        model2.desc = "代办任务"
        model2.buttons = [itemModel,itemModel,itemModel,itemModel,
                          itemModel,itemModel,itemModel,itemModel,
                          itemModel]
        model2.itemType = .task
        
        let model3 = HKHomeItemModel.init()
        model3.desc = "常用工具"
        model3.itemType = .tools
        model3.buttons = [itemModel,itemModel,itemModel,itemModel,
                          itemModel,itemModel]
        
        
        dataArr.append(model1)
        dataArr.append(model2)
        dataArr.append(model3)
        
        self.tableView.reloadData()
    }
    
    // MARK: - UI
    func configUI()  {
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.tableView.register(HKHomeCell.self, forCellReuseIdentifier: "HKHomeCell")
        self.tableView.tableHeaderView = self.headerView
        self.view.addSubview(tableView)
                
        self.tableView.reloadData()
    }
        
    lazy var tableView: UITableView = {
        let bottom = (self.tabBarController?.tabBar.isHidden ?? true) ? YX_SafeArea_Bottom() : 49 + YX_SafeArea_Bottom()
        return UITableView().frame(0, 0, YX_AppW(), YX_ScreenH())
            .contentInset(0, 0, CGFloat(bottom), 0)
            .backgroundColor(.lightGray)
            .config { (tab) in
                tab.delegate = self
                tab.dataSource = self
                tab.separatorStyle = .none
        }
    }()
    
    lazy var headerView: HKHomeHeaderView = {
        let view = HKHomeHeaderView.init(frame: CGRect(x: 0, y: 0, width: YX_AppW(), height: 200))
        return view
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height =  tableView.fd_heightForCell(withIdentifier: "HKHomeCell", cacheBy: indexPath) { (cell) in
            if let newCell = cell as? HKHomeCell {
                newCell.reloadCell(self.dataArr[indexPath.row])
            }
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:HKHomeCell! = tableView.dequeueReusableCell(withIdentifier: "HKHomeCell") as? HKHomeCell
        if cell == nil {
            cell = HKHomeCell(style: .default, reuseIdentifier: "HKHomeCell")
        }
        cell.reloadCell(self.dataArr[indexPath.row])
        return cell
    }
    
    
}

