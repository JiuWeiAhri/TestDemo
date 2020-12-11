//
//  HKBannerView.swift
//  MarsCar
//
//  Created by AhriLiu on 2020/12/8.
//  Copyright © 2020 TaoChe. All rights reserved.
//

import UIKit

protocol HKBannerViewDelegate : NSObjectProtocol {
    
    /// bannerView - [Ur] l数组
    func hk_bannerViewImageUrl(_ bannerView : HKBannerView)-> [String]
    
    /// bannerView - 点击了某个Index
    func hk_bannerDidClickAtIndex(_ bannerView : HKBannerView, _ index : Int)
    
    /// bannerView - 将要展示
    func hk_bannerwillDisplayAtIndex(_ bannerView : HKBannerView, _ index : Int)
    
    /// bannerView - 重新布局后会调用
    func hk_bannerLayoutSubViews(_ bannerView : HKBannerView)
    
}

class HKBannerView: UIView, UIScrollViewDelegate{
    
    /// 自动滚动。默认 true
    var autoScroll : Bool = true
    /// 循环滚动。默认 true
    var cycleScroll : Bool = true
    /// 代理
    weak var delegate : HKBannerViewDelegate?
    
    
    // MARK : - 公用方法
    /// 刷新
    func reloadBannerData()  {
        self.configData()
        self.pageControl.isHidden = self.pageControl.numberOfPages == 1
        self.colletionV.reloadData()
        self.setNeedsLayout()
    }
    
    // MARK: - 私有属性 / 方法
    private var autoScrollerTimer : Timer?
    private var bannerUrls : [String] = []
    private var totalCount : Int = 0
    
    func setUpTimer() {
        if self.autoScroll && self.bannerUrls.count > 1 {
            self.autoScrollerTimer = Timer.scheduledTimer(timeInterval:3, target: self, selector: #selector(autoScrollAction), userInfo: nil, repeats: true)
            RunLoop.main.add((self.autoScrollerTimer)!, forMode: .common)
        }
    }
    func configData()  {
        self.autoScrollerTimer?.invalidate()
        self.autoScrollerTimer = nil

        // 数据源
        if self.delegate != nil  {
            self.bannerUrls = self.delegate!.hk_bannerViewImageUrl(self)
        }
        self.totalCount = (self.cycleScroll && self.bannerUrls.count > 1 ) ? ( self.bannerUrls.count * 10 ) : self.bannerUrls.count
        self.pageControl.numberOfPages = self.bannerUrls.count
        
        self.setUpTimer()
    }
    
    override func layoutSubviews() {
        self.pageControl.sizeToFit()
        
        var pageFrame = self.pageControl.frame
        let defaultX = self.frame.size.width/2 - pageFrame.size.width/2
        let defultY = self.frame.size.height - pageFrame.size.height
        
        pageFrame.origin = CGPoint(x: defaultX, y: defultY)
        
        self.pageControl.frame = pageFrame
        
        if self.delegate != nil  {
            self.delegate!.hk_bannerLayoutSubViews(self)
        }
        
    }
    
    // 自动滚动
    @objc func autoScrollAction() {
        
        let currentIndex : Int  = Int((self.colletionV.contentOffset.x + self.colletionV.frame.size.width * 0.5) / self.colletionV.frame.size.width)
        var targetIndex : Int = Int(currentIndex + 1)
        if targetIndex == self.totalCount {
            targetIndex = Int (Double(self.totalCount) * 0.5)
            self.colletionV.setContentOffset(CGPoint(x:  CGFloat(targetIndex-1) * self.colletionV.width, y: 0), animated: true)
        } else if (targetIndex < self.totalCount) {
            self.colletionV.setContentOffset(CGPoint(x: CGFloat(targetIndex) * self.colletionV.width, y: 0), animated: true)
        } else {
            self.colletionV.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    // MARK: - life
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.colletionV.delegate = self
        self.colletionV.dataSource = self
        self.addSubView(self.colletionV)
        self.addSubView(self.pageControl)
        
        self.colletionV.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self)
        }
        self.pageControl.backgroundColor = .red
        
    }
    
    //
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            self.autoScrollerTimer?.invalidate()
            self.autoScrollerTimer = nil
        } else {
            self.setUpTimer()
        }
    }
    
    // MARK: - Scorller
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.bannerUrls.count == 0 {
            return
        }
        let index : Int = Int((scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width)
        self.pageControl.currentPage = Int(index % self.bannerUrls.count)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.autoScrollerTimer?.invalidate()
        self.autoScrollerTimer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setUpTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.cycleScroll && self.bannerUrls.count > 1 {
            let a : Int = Int(self.colletionV.contentOffset.x) + Int(self.colletionV.frame.size.width * 0.5)
            let b : Int = Int(self.colletionV.frame.size.width)
            var currentIndex : Int = Int (a / b)
            if currentIndex == 0  {
                currentIndex = Int(Double(self.totalCount) * 0.5)
                let centerBeginIndexPath = IndexPath.init(item: currentIndex, section: 0)
                self.colletionV.scrollToItem(at: centerBeginIndexPath, at: .centeredHorizontally, animated: false)
            } else if (currentIndex == self.totalCount - 1) {
                currentIndex = Int(Double(self.totalCount) * 0.5)
                let centerBeginIndexPath = IndexPath.init(item: currentIndex-1, section: 0)
                self.colletionV.scrollToItem(at: centerBeginIndexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    // MARK : - lazy
    
    private lazy var colletionV : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = self.frame.size
        
        let collectionV =  UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(HKBannerViewCollectionCell.classForCoder(), forCellWithReuseIdentifier: "HKBannerViewCollectionCell")
        
        return collectionV
    }()
    
    private lazy var pageControl : UIPageControl = {
        return UIPageControl.init()
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HKBannerView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HKBannerViewCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HKBannerViewCollectionCell", for: indexPath) as! HKBannerViewCollectionCell
        let index = indexPath.item % self.bannerUrls.count
        let imgUrl = self.bannerUrls[index]
        cell.reloadBy(imgUrl, "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.delegate != nil  {
            let index = indexPath.item % self.bannerUrls.count
            self.delegate!.hk_bannerwillDisplayAtIndex(self,index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil  {
            let index = indexPath.item % self.bannerUrls.count
            self.delegate!.hk_bannerDidClickAtIndex(self,index)
        }
    }
    
    
}
