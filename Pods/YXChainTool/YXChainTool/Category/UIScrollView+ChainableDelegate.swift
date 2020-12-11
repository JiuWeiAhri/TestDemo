//
//  UIScrollView+Delegate.swift
//  YXChainTool
//
//  Created by zhuxuewei on 2018/5/28.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit

private struct YXScrollViewAssociatedKeys {
    static var willBeginDraggingKey = "willBeginDraggingKey"
    static var willEndDraggingKey = "willEndDraggingKey"
    static var didEndDraggingKey = "didEndDraggingKey"
    static var willBeginDeceleratingKey = "willBeginDeceleratingKey"
    static var didEndDeceleratingKey = "didEndDeceleratingKey"
    static var didScrollKey = "didScrollKey"
    static var scrollViewDelegateKey = "scrollViewDelegateKey"
}

public extension UIScrollView {

    //MARK: Dragging
    @discardableResult
    func scrollViewWillBeginDragging(_ action:@escaping (UIScrollView) -> ()) -> Self {
        setAssociatedObject(key: &YXScrollViewAssociatedKeys.willBeginDraggingKey, action: action)
        return self
    }
    
    @discardableResult
    func scrollViewWillEndDragging(_ action:@escaping (UIScrollView, _ velocity: CGPoint, _ targetContentOffset: UnsafeMutablePointer<CGPoint>) -> ()) -> Self {
        setAssociatedObject(key: &YXScrollViewAssociatedKeys.willEndDraggingKey, action: action)
        return self
    }
    
    @discardableResult
    func scrollViewDidEndDragging(_ action:@escaping (UIScrollView, _ decelerate: Bool) -> ()) -> Self {
        setAssociatedObject(key: &YXScrollViewAssociatedKeys.didEndDraggingKey, action: action)
        return self
    }
    
    //MARK: Decelerating
    @discardableResult
    func scrollViewWillBeginDecelerating(_ action:@escaping (UIScrollView) -> ()) -> Self {
        setAssociatedObject(key: &YXScrollViewAssociatedKeys.willBeginDeceleratingKey, action: action)
        return self
    }
    
    @discardableResult
    func scrollViewDidEndDecelerating(_ action:@escaping (UIScrollView) -> ()) -> Self {
        setAssociatedObject(key: &YXScrollViewAssociatedKeys.didEndDeceleratingKey, action: action)
        return self
    }
    
    //MARK: other
    @discardableResult
    func scrollViewDidScroll(_ action:@escaping (UIScrollView) -> ()) -> Self {
        setAssociatedObject(key: &YXScrollViewAssociatedKeys.didScrollKey, action: action)
        return self
    }
    
    private func setAssociatedObject(key: UnsafeRawPointer!, action: Any?) {
        
        if objc_getAssociatedObject(self, &YXScrollViewAssociatedKeys.scrollViewDelegateKey) == nil {
            let delegate = YXScrollViewDelegate()
            self.delegate = delegate
            objc_setAssociatedObject(self, &YXScrollViewAssociatedKeys.scrollViewDelegateKey, delegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        objc_setAssociatedObject(self, key, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
}

private class YXScrollViewDelegate: NSObject, UIScrollViewDelegate {
    
    //MARK: Dragging
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let action = objc_getAssociatedObject(scrollView, &YXScrollViewAssociatedKeys.willBeginDraggingKey) as? (UIScrollView) -> () {
            action(scrollView)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let action = objc_getAssociatedObject(scrollView, &YXScrollViewAssociatedKeys.willEndDraggingKey) as? (UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> () {
            action(scrollView, velocity, targetContentOffset)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let action = objc_getAssociatedObject(scrollView, &YXScrollViewAssociatedKeys.didEndDraggingKey) as? (UIScrollView, Bool) -> () {
            action(scrollView, decelerate)
        }
    }
    
    //MARK: Decelerating
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if let action = objc_getAssociatedObject(scrollView, &YXScrollViewAssociatedKeys.willBeginDeceleratingKey) as? (UIScrollView) -> () {
            action(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let action = objc_getAssociatedObject(scrollView, &YXScrollViewAssociatedKeys.didEndDeceleratingKey) as? (UIScrollView) -> () {
            action(scrollView)
        }
    }
    
    //MARK: other
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let action = objc_getAssociatedObject(scrollView, &YXScrollViewAssociatedKeys.didScrollKey) as? (UIScrollView) -> () {
            action(scrollView)
        }
    }
}



