//
//  HKHomeItemCollectionCell.swift
//  MarsCar
//
//  Created by AhriLiu on 2020/12/7.
//  Copyright © 2020 TaoChe. All rights reserved.
//

import UIKit


class HKHomeItemCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    // MARK: - refresh
    func reloadCellBy(_ model : HKHomeButtonsModel, _ itemType : HKHomeItemType) {
        
        titleL.text = model.desc
        iconViewTitle.text = model.desc

        monthNumL.text = model.code
        taskNumL.text = model.code
        
        configFrame(itemType)
    }
    
    func configFrame(_ type : HKHomeItemType) {
        
        hiddenAllItem()
        
        switch type {
            
        case .monthData:
            titleL.isHidden = false
            monthNumL.isHidden = false
            monthNumL.frame(0, 16, self.width, 25)
            titleL.frame(0, monthNumL.bottom+5, self.width, 20)
            iconView.image = UIImage.init(named: "home_money")

        case .task:
            iconViewTitle.isHidden = false
            taskNumL.isHidden = false
            iconView.isHidden = false
            iconView.frame(0, 10, self.width, 54)
            taskNumL.frame(0, 6, self.width, 25)
            iconViewTitle.frame(0, taskNumL.bottom+5, self.width, 20)
            iconView.image = UIImage.init(named: "home_tool_new")

        case .tools:
            iconView.isHidden = false
            titleL.isHidden = false
            iconView.frame(self.width/2-17, 10,35, 35)
            titleL.frame(0, iconView.bottom + 5, self.width, 30)
            iconView.image = UIImage.init(named: "home_money")

        }
        
    }

    // MARK: - UI
    func configUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleL)
        contentView.addSubview(monthNumL)
        iconView.addSubview(taskNumL)
        iconView.addSubview(iconViewTitle)
    }
    
    func hiddenAllItem() {
        titleL.isHidden = true
        iconView.isHidden = true
        monthNumL.isHidden = true
        taskNumL.isHidden = true
        iconViewTitle.isHidden = true
    }
    
    // MARK: - Lazy

    lazy var iconView : UIImageView = {
        return UIImageView().frame(10, 10, self.width, self.height)
            .contentMode(.scaleAspectFill)
            .config { (view) in
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
        }
    }()
    
    lazy var titleL : UILabel = {
        return UILabel().font(fontSize: 14).textAlignment(.center)
    }()
    lazy var iconViewTitle : UILabel = {
        return UILabel().font(fontSize: 13).textAlignment(.left).textColor(.darkGray)
    }()
    lazy var monthNumL : UILabel = {
        return UILabel().font(fontSize: 20).textAlignment(.center).textColor(.blue)
     }()
    
    lazy var taskNumL : UILabel = {
        return UILabel().font(fontSize: 20).textAlignment(.left).textColor(.black)
     }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


