//
//  HKBannerViewCollectionCell.swift
//  MarsCar
//
//  Created by AhriLiu on 2020/12/8.
//  Copyright © 2020 TaoChe. All rights reserved.
//

import UIKit

class HKBannerViewCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView(imageV)
        imageV.mas_makeConstraints { (make ) in
            make?.edges.equalTo()(self)
        }
    }
    
    func reloadBy(_ url: String , _ str : String)  {
        imageV.image("home_banner_default")
    }
    
    lazy var imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        return imageV
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
