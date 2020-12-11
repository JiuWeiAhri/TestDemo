//
//  UIResponder+Chainable.swift
//  YXChainTool
//
//  Created by zhuxuewei on 2018/5/28.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit

private struct YXControlAssociatedKeys {
    static var warpperKey = "kWarpperKey"
}

public extension ViewChainable where Self: UIControl {

    @discardableResult
    func addAction(_ controlEvents: UIControl.Event, action: @escaping (UIControl) -> ()) -> Self {
        
        self.removeAction(for: controlEvents)
        var warppers = objc_getAssociatedObject(self, &YXControlAssociatedKeys.warpperKey) as? [YXControlWarpper]
        if warppers == nil {
            warppers = [YXControlWarpper]()
        }
        let warpper = YXControlWarpper(controlEvents, action: action)
        warppers!.append(warpper)
        objc_setAssociatedObject(self, &YXControlAssociatedKeys.warpperKey, warppers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.addTarget(warpper, action: #selector(YXControlWarpper.invoke(_:)), for: controlEvents)
        return self
    }
    
    @discardableResult
    func removeAction(for controlEvents: UIControl.Event ) -> Self {
        var warppers = objc_getAssociatedObject(self, &YXControlAssociatedKeys.warpperKey) as? [YXControlWarpper]
        if warppers == nil || warppers!.count == 0 {
            return self
        }
        warppers = warppers?.filter({ (item) -> Bool in
            return item.controlEvents != controlEvents
        })
        objc_setAssociatedObject(self, &YXControlAssociatedKeys.warpperKey, warppers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    @discardableResult
    func removeAllAction() -> Self {
        objc_setAssociatedObject(self, &YXControlAssociatedKeys.warpperKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
}

private class YXControlWarpper: NSObject {
    
    var controlEvents : UIControl.Event?
    
    var action : (UIControl) -> ()?
    
    init(_ controlEvents: UIControl.Event, action : @escaping (UIControl) -> ()) {
        self.controlEvents = controlEvents
        self.action = action
    }
    
    @objc func invoke(_ sender: UIControl) {
        self.action(sender);
    }
}
