//
//  HKHomeHeaderView.swift
//  MarsCar
//
//  Created by AhriLiu on 2020/12/7.
//  Copyright © 2020 TaoChe. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell
import Masonry
import YXKitOC

class HKHomeHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        
        let bgV = UIImageView.init(frame: CGRect(x: 0, y: 0, width: YX_AppW(), height: 148))
        bgV.image = UIImage.init(named: "home_bg")
        bgV.contentMode = .scaleAspectFill
        self.addSubview(bgV)
        
        self.addSubview(titleL)
        self.addSubview(rightBtn)
        
        
        bannerView.cycleScroll = true
        bannerView.delegate = self
        self.addSubview(bannerView)

        
        configUIframe()
        bannerView.backgroundColor = .white
    }
    
    func configUIframe() {
        
        self.titleL.mas_makeConstraints { (make) in
            make?.left.equalTo()(20)
            make?.right.equalTo()(-20)
            make?.top.equalTo()(20)
            make?.height.equalTo()(40)
        }
        
        self.rightBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(20)
            make?.right.equalTo()(-50)
            make?.centerY.equalTo()(titleL)
            make?.width.equalTo()(40)
        }
        
        self.bannerView.mas_remakeConstraints { (make) in
            make?.top.equalTo()(rightBtn.mas_bottom)?.offset()(10)
            make?.left.equalTo()(15)
            make?.right.equalTo()(-15)
            make?.height.equalTo()(120)
            make?.bottom.equalTo()(0)
        }
        
        self.bannerView.layer.cornerRadius = 6
        self.bannerView.clipsToBounds = true

        bannerView.reloadBannerData()
    }
    
    lazy var titleL : UILabel = {
        return UILabel().textAlignment(.left).font(fontSize: 20).textColor(.white)
    }()
    
    lazy var rightBtn : UIButton = {
        return UIButton().title("✉️", for: .normal)
    }()
    
    lazy var bannerView : HKBannerView = {
        return HKBannerView.init()
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HKHomeHeaderView : HKBannerViewDelegate {

    func hk_bannerViewImageUrl(_ bannerView: HKBannerView) -> [String] {
        return ["11","22"]
    }
    
    func hk_bannerDidClickAtIndex(_ bannerView: HKBannerView, _ index: Int) {
        print("点击了  \(index)")
    }
    
    func hk_bannerwillDisplayAtIndex(_ bannerView: HKBannerView, _ index: Int) {
        
    }
    
    func hk_bannerLayoutSubViews(_ bannerView: HKBannerView) {
        
    }
    
    
}
