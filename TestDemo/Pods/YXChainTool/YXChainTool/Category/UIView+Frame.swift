//
//  UIView+Frame.swift
//  YXChainTool
//
//  Created by zhuxuewei on 2018/5/25.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit

//MARK: - set/get 视图的Frame
public extension UIView {

    /// left
    var left: CGFloat {
        get {
            return frame.minX
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// right
    var right: CGFloat {
        get {
            return frame.maxX
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue - tempFrame.width
            frame = tempFrame
        }
    }
    
    /// top
    var top: CGFloat {
        get {
            return frame.minY
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame = tempFrame
        }
    }
    
    /// bottom
    var bottom: CGFloat {
        get {
            return frame.maxY
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue - tempFrame.height
            frame = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    var topRight: CGPoint {
        get {
            return CGPoint(x: frame.maxX, y: frame.minY)
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue.x - tempFrame.width
            frame = tempFrame
        }
    }
    
    var leftBottom: CGPoint {
        get {
            return CGPoint(x: frame.minX, y: frame.maxY)
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue.y - tempFrame.height
            frame = tempFrame
        }
    }
    
    var rightBottom: CGPoint {
        get {
            return CGPoint(x: frame.maxX, y: frame.maxY)
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue.x - tempFrame.width
            tempFrame.origin.y = newValue.y - tempFrame.height
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
}

