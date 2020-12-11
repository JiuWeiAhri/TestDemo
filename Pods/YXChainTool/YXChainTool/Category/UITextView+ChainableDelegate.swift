//
//  UITextView+Delegate.swift
//  YXChainTool
//
//  Created by zhuxuewei on 2019/5/13.
//  Copyright © 2019年 yxqiche. All rights reserved.
//

import UIKit

private struct YXTextViewAssociatedKeys {
    static var textViewShouldBeginEditingKey = "textViewShouldBeginEditingKey"
    static var textViewShouldEndEditingKey = "textViewShouldEndEditingKey"
    static var textViewDidBeginEditingKey = "textViewDidBeginEditingKey"
    static var textViewDidEndEditingKey = "textViewDidEndEditingKey"
    static var textViewDidChangeKey = "textViewDidChangeKey"
    static var textViewDidChangeSelectionKey = "textViewDidChangeSelectionKey"
    static var textViewShouldChangeTextInRangeKey = "textViewShouldChangeTextInRangeKey"
    static var textViewShouldInteractWithURLKey = "textViewShouldInteractWithURLKey"
    static var textViewShouldInteractWithTextAttachmentKey = "textViewShouldInteractWithTextAttachmentKey"
    static var textViewDelegateKey = "textFieldDelegateKey"
}

public extension UITextView {

    @discardableResult
    func textViewShouldBeginEditing(_ action:@escaping (UITextView) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewShouldBeginEditingKey, action: action)
    }
    
    @discardableResult
    func textViewShouldEndEditing(_ action:@escaping (UITextView) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewShouldEndEditingKey, action: action)
    }
    
    @discardableResult
    func textViewDidBeginEditing(_ action:@escaping (UITextView) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewDidBeginEditingKey, action: action)
    }
    
    @discardableResult
    func textViewDidEndEditing(_ action:@escaping (UITextView) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewDidEndEditingKey, action: action)
    }
    
    @discardableResult
    func textViewDidChange(_ action:@escaping (UITextView) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewDidChangeKey, action: action)
    }
    
    @discardableResult
    func textViewDidChangeSelection(_ action:@escaping (UITextView) -> ()) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewDidChangeSelectionKey, action: action)
    }
    
    @discardableResult
    func textViewShouldChangeTextInRange(_ action:@escaping (_ textView: UITextView, _ range: NSRange, _ replacementText: String) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewShouldChangeTextInRangeKey, action: action)
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func textViewShouldInteractWithURL(_ action:@escaping (_ textView: UITextView, _ url: NSURL, _ characterRange: NSRange, _ interaction: UITextItemInteraction?) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewShouldInteractWithURLKey, action: action)
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func textViewShouldInteractWithTextAttachment(_ action:@escaping (_ textView: UITextView, _ textAttachment: NSTextAttachment, _ characterRange: NSRange, _ interaction: UITextItemInteraction?) -> Bool) -> Self {
        return setAssociatedObject(key: &YXTextViewAssociatedKeys.textViewShouldInteractWithTextAttachmentKey, action: action)
    }
    
    
    private func setAssociatedObject(key: UnsafeRawPointer!, action: Any?) -> Self {
        
        if objc_getAssociatedObject(self, &YXTextViewAssociatedKeys.textViewDelegateKey) == nil {
            let delegate = YXTextViewDelegate()
            self.delegate = delegate
            objc_setAssociatedObject(self, &YXTextViewAssociatedKeys.textViewDelegateKey, delegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        objc_setAssociatedObject(self, key, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
}

private class YXTextViewDelegate: NSObject, UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewShouldBeginEditingKey) as? (UITextView) -> Bool {
            return action(textView)
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewShouldEndEditingKey) as? (UITextView) -> Bool {
            return action(textView)
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewDidBeginEditingKey) as? (UITextView) -> () {
            action(textView)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewDidEndEditingKey) as? (UITextView) -> () {
            action(textView)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewDidChangeKey) as? (UITextView) -> () {
            action(textView)
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewDidChangeSelectionKey) as? (UITextView) -> () {
            action(textView)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewShouldChangeTextInRangeKey) as? (UITextView, NSRange, String) -> Bool {
            return action(textView, range, text)
        }
        return true
    }
    
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewShouldInteractWithURLKey) as? (UITextView, URL, NSRange, UITextItemInteraction?) -> Bool {
            return action(textView, URL, characterRange, interaction);
        }
        return true
    }
    
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let action = objc_getAssociatedObject(textView, &YXTextViewAssociatedKeys.textViewShouldInteractWithTextAttachmentKey) as? (UITextView, NSTextAttachment, NSRange, UITextItemInteraction?) -> Bool {
            return action(textView, textAttachment, characterRange, interaction);
        }
        return true
    }
    
    
}


