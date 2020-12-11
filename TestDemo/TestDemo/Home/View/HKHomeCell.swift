//
//  HKHomeCell.swift
//  MarsCar
//
//  Created by AhriLiu on 2020/12/7.
//  Copyright © 2020 TaoChe. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell
import Masonry
import YXKitOC

class HKHomeCell: UITableViewCell {
    
    private var collectionDataArr : [HKHomeButtonsModel] = []
    private var itemModel : HKHomeItemModel = HKHomeItemModel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .lightGray
        configUI()
    }
    

    
    func reloadCell(_ model: HKHomeItemModel)  {
        
        self.itemModel = model
        titleL.text(model.desc)
        collectionDataArr = model.buttons
        colletionView.reloadData()
        
        let dataArr = [3,4,6,9,12]
        for (_,value) in dataArr.enumerated()  {
            print("输入：\(value)")
            print("结果：\(Int((value-1)/4)+1)")
            
        }
        
        let h = (model.buttons.count/4 + 1)

        print(h)

        self.colletionView.mas_remakeConstraints { (make) in
                 make?.top.equalTo()(self.titleL.mas_bottom)?.offset()(8)
                 make?.left.equalTo()(12)
                 make?.right.equalTo()(-12)
                 make?.height.equalTo()(h)
                 make?.bottom.equalTo()(-10)
             }
    }
    
    
    // MARK: -
    
    func configUI()  {
        contentView.addSubview(baseView)
        baseView.addSubview(titleL)
        baseView.addSubview(colletionView)
        configUIFrame()
    }
    
    func configUIFrame() {

        self.titleL.mas_makeConstraints { (make) in
            make?.top.equalTo()(20)
            make?.left.equalTo()(15)
            make?.right.equalTo()(-15)
        }
        
        self.colletionView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.titleL.mas_bottom)?.offset()(8)
            make?.left.equalTo()(12)
            make?.right.equalTo()(-12)
            make?.height.equalTo()(100)
            make?.bottom.equalTo()(-10)
        }
        
        self.baseView.mas_makeConstraints { (make) in
            make?.left.top()?.equalTo()(15)
            make?.right.equalTo()(-15)
            make?.bottom.equalTo()(-5)
        }
        
        self.baseView.layer.cornerRadius = 6
        self.baseView.clipsToBounds = true
        
    }
    
    // MARK: - Lazy
    lazy var baseView : UIView  = {
        return UIView().backgroundColor(.white)
    }()
    
    lazy var titleL : UILabel = {
        return UILabel().font(fontSize: 20) .textColor(.black).numberOfLines(0).backgroundColor(.white)
    }()
    
    lazy var colletionView : UICollectionView = {
      let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width-74)/4,
                                 height: (UIScreen.main.bounds.size.width-74)/4)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: self.frame, collectionViewLayout: layout)
            .config { (co) in
                co.allowsMultipleSelection = true
                co.backgroundColor = .white
                co.isPagingEnabled = true
                co.delegate = self
                co.dataSource = self
                co.register(HKHomeItemCollectionCell.self, forCellWithReuseIdentifier: "HKHomeItemCollectionCell")
        }
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HKHomeCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HKHomeItemCollectionCell",
                                                      for: indexPath) as! HKHomeItemCollectionCell
        

        cell.reloadCellBy(collectionDataArr[indexPath.row], self.itemModel.itemType)
        return cell
    }
    
    
    
}

