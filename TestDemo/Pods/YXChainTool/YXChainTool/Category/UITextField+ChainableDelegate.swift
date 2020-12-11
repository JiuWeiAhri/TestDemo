//
//  UITextField+Chainable.swift
//  YXChainTool
//
//  Created by zhuxuewei on 2018/5/28.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit

private struct YXTextFieldAssociatedKeys {
    static var shouldBeginEditingKey = "shouldBeginEditingKey"
    static var didBeginEditingKey = "didBeginEditingKey"
    static var shouldEndEditingKey = "shouldEndEditingKey"
    static var didEndEditingKey = "didEndEditingKey"
    static var shouldClearKey = "shouldClearKey"
    static var shouldReturnKey = "shouldReturnKey"
    static var didEndEditingWithReasonKey = "didEndEditingWithReasonKey"
    static var shouldChangeCharactersKey = "shouldChangeCharactersKey"
    static var textFieldDelegateKey = "textFieldDelegateKey"
}


public extension UITextField {

    @discardableResult
    func textFieldShouldBeginEditing(_ action:@escaping (UITextField) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.shouldBeginEditingKey, action: action)
    }
    
    @discardableResult
    func textFieldDidBeginEditing(_ action:@escaping (UITextField) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.didBeginEditingKey, action: action)
    }
    
    @discardableResult
    func textFieldShouldEndEditing(_ action:@escaping (UITextField) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.shouldEndEditingKey, action: action)
    }
    
    @discardableResult
    func textFieldDidEndEditing(_ action:@escaping (UITextField) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.didEndEditingKey, action: action)
    }
    
    @discardableResult
    func textFieldShouldClear(_ action:@escaping (UITextField) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.shouldClearKey, action: action)
    }
    
    @discardableResult
    func textFieldShouldReturn(_ action:@escaping (UITextField) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.shouldReturnKey, action: action)
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func textFieldDidEndEditingReason(_ action:@escaping (UITextField, _ reason: UITextField.DidEndEditingReason) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.didEndEditingWithReasonKey, action: action)
    }
    
    @discardableResult
    func textFieldShouldChangeCharacters(_ action:@escaping (UITextField, _ range: NSRange, _ replacementString: String) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextFieldAssociatedKeys.shouldChangeCharactersKey, action: action)
    }
    
    private func setAssociatedObject(key: UnsafeRawPointer!, action: Any?) -> Self {
        
        if objc_getAssociatedObject(self, &YXTextFieldAssociatedKeys.textFieldDelegateKey) == nil {
            let delegate = YXTextFieldDelegate()
            self.delegate = delegate
            objc_setAssociatedObject(self, &YXTextFieldAssociatedKeys.textFieldDelegateKey, delegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        objc_setAssociatedObject(self, key, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
}


private class YXTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.shouldBeginEditingKey) as? (UITextField) -> Bool {
            return action(textField)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.didBeginEditingKey) as? (UITextField) -> () {
            action(textField)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.shouldEndEditingKey) as? (UITextField) -> Bool {
            return action(textField)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.didEndEditingKey) as? (UITextField) -> () {
            action(textField)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.shouldClearKey) as? (UITextField) -> Bool {
            return action(textField)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.shouldReturnKey) as? (UITextField) -> Bool {
            return action(textField)
        }
        return true
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.didEndEditingWithReasonKey) as? (UITextField, UITextField.DidEndEditingReason) -> () {
            action(textField, reason)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let action = objc_getAssociatedObject(textField, &YXTextFieldAssociatedKeys.shouldChangeCharactersKey) as? (UITextField, NSRange, String) -> Bool {
            return action(textField, range, string)
        }
        return true
    }
}




