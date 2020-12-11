//
//  UIView+Chainable.swift
//  YXChainTool
//
//  Created by zhuxuewei on 2018/5/25.
//  Copyright © 2018年 yxqiche. All rights reserved.
//

import UIKit


public protocol ViewChainable {}

public extension ViewChainable where Self: UIView {
    
    /*
     可以在闭包内配置view的各种属性
     discardableResult 关键值的作用是 忽略返回值没有变量接收时的警告⚠️
     */
    @discardableResult
    func config(config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
    
//MARK: frame相关
    @discardableResult
    func top(_ top: CGFloat) -> Self {
        self.top = top
        return self
    }
    
    @discardableResult
    func left(_ left: CGFloat) -> Self {
        self.left = left
        return self
    }
    
    @discardableResult
    func bottom(_ bottom: CGFloat) -> Self {
        self.bottom = bottom
        return self
    }
    
    @discardableResult
    func right(_ right: CGFloat) -> Self {
        self.right = right
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> Self {
        self.height = height
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> Self {
        self.width = width
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> Self {
        self.size = size
        return self
    }
    
    @discardableResult
    func size(_ w: CGFloat, _ h: CGFloat) -> Self {
        self.size = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func center(_ center: CGPoint) -> Self {
        self.center = center
        return self
    }
    
    @discardableResult
    func center(_ x: CGFloat, _ y: CGFloat) -> Self {
        self.center = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func centerX(_ centerX: CGFloat) -> Self {
        self.centerX = centerX
        return self
    }
    
    @discardableResult
    func centerY(_ centerY: CGFloat) -> Self {
        self.centerY = centerY
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func frame(_ x: CGFloat, _ y:CGFloat, _ w: CGFloat, _ h: CGFloat) -> Self {
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        return self
    }
    
    @discardableResult
    func bounds(_ bounds: CGRect) -> Self {
        self.bounds = bounds
        return self
    }
    
//MARK: UI相关
    
    /// 添加到父视图上
    @discardableResult
    
    func addHere(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    @discardableResult
    func addSubView(_ subView: UIView) -> Self {
        addSubview(subView)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ isClips: Bool) -> Self {
        self.clipsToBounds = isClips
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat, position: UIRectCorner = .allCorners) -> Self {
        if position == .allCorners {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: position, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let layer = CAShapeLayer()
            layer.frame = bounds
            layer.path = path.cgPath
            self.layer.mask = layer
        }
        return self
    }
    
    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> Self {
        self.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func borderColor(_ borderColor: UIColor?) -> Self {
        self.layer.borderColor = borderColor?.cgColor
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func eachSubview(_ each: (UIView)->()) -> Self {
        for view in subviews {
            each(view)
        }
        return self;
    }
    
    @discardableResult
    func removeAllSubview() -> Self {
        for view in subviews {
            view.removeFromSuperview()
        }
        return self;
    }
    
    //MARK: 事件相关
    /*
     给view添加一个点击事件
     */
    @discardableResult
    func tapAction(action:@escaping () -> ()) -> Self {
        
        // 先移除之前的单击手势，防止重复添加手势
        if let gestureRecognizers = self.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let tap = gesture as? UITapGestureRecognizer {
                    self.removeGestureRecognizer(tap)
                }
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.addGestureRecognizer(tap)
        objc_setAssociatedObject(self, &YXViewAssociatedKeys.tapKey, action, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
    
    
    @discardableResult
    func userInteractionEnabled(enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    func multipleTouchEnabled(enabled: Bool) -> Self {
        self.isMultipleTouchEnabled = enabled
        return self
    }
}


private struct YXViewAssociatedKeys {
    static var tapKey = "kTapActionKey"
}

extension UIView: ViewChainable
{
    @objc fileprivate func tapGestureRecognizerAction() {
        let action = objc_getAssociatedObject(self, &YXViewAssociatedKeys.tapKey) as? () -> ()
        action?()
    }
}


public extension UIImageView {
    
    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self;
    }
    
    @discardableResult
    func image(_ imageName: String) -> Self {
        self.image = UIImage(named: imageName)
        return self
    }
    
    @discardableResult
    func highlightedImage(_ image: UIImage?) -> Self {
        self.image = image
        return self;
    }
    
    @discardableResult
    func highlightedImage(_ imageName: String) -> Self {
        self.image = UIImage(named: imageName)
        return self
    }
    
    @discardableResult
    func animationImages(_ images: [UIImage]?) -> Self {
        self.animationImages = images
        return self
    }
    
    @discardableResult
    func highlightedAnimationImages(_ images: [UIImage]?) -> Self {
        self.animationImages = images
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self;
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self;
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self;
    }
    
    
    @discardableResult
    func animationDuration(_ duration: TimeInterval) -> Self {
        self.animationDuration = duration
        return self;
    }
    
    @discardableResult
    func animationRepeatCount(_ repeatCount: Int) -> Self {
        self.animationRepeatCount = repeatCount
        return self;
    }
}

public extension UILabel {
    
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text;
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        self.textColor = color;
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ isAdjustFont: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = isAdjustFont
        return self
    }
    
    @discardableResult
    func minimumScaleFactor(_ scale: CGFloat) -> Self {
        self.minimumScaleFactor = scale
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString) -> Self {
        self.attributedText = text;
        return self
    }
    
    @discardableResult
    func shadowColor(_ color: UIColor) -> Self {
        self.shadowColor = color;
        return self
    }
    
    @discardableResult
    func highlightedTextColor(_ color: UIColor) -> Self {
        self.highlightedTextColor = color;
        return self
    }
    
    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        self.shadowOffset = offset;
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func baselineAdjustment(_ adjustment: UIBaselineAdjustment) -> Self {
        self.baselineAdjustment = adjustment
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isBool: Bool) -> Self {
        self.isHighlighted = isBool
        return self
    }
}

public extension UIButton {
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func title(_ title: String?, color: UIColor? = nil, for state: UIControl.State) -> Self {
        setTitle(title, for: state)
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func image(_ imageName: String, for state: UIControl.State) -> Self {
        setImage(UIImage(named: imageName), for: state)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage, for state: UIControl.State) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ imageName: String, for state: UIControl.State) -> Self {
        setBackgroundImage(UIImage(named: imageName), for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage, for state: UIControl.State) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    @discardableResult
    @available(iOS 9.0, *)
    func semanticContentAttribute(_ semanticContentAttribute: UISemanticContentAttribute) -> Self {
        self.semanticContentAttribute = semanticContentAttribute
        return self
    }
    
    @discardableResult
    func contentEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func adjustsImageWhenHighlighted(_ isAdjust: Bool) -> Self {
        self.adjustsImageWhenHighlighted = isAdjust
        return self
    }
    
    @discardableResult
    func adjustsImageWhenDisabled(_ isAdjust: Bool) -> Self {
        self.adjustsImageWhenDisabled = isAdjust
        return self
    }
    
    @discardableResult
    func showsTouchWhenHighlighted(_ isAdjust: Bool) -> Self {
        self.showsTouchWhenHighlighted = isAdjust
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color;
        return self
    }
}

public extension UITextField {
    
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text;
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self;
    }
    
    @discardableResult
    func textColor(_ color: UIColor?) -> Self {
        self.textColor = color;
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString?, textAttributes: [NSAttributedString.Key : Any]? = nil) -> Self {
        self.attributedText = text;
        if let attributes = textAttributes {
            self.defaultTextAttributes = attributes
        }
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ text: NSAttributedString?) -> Self {
        self.attributedPlaceholder = text;
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func borderStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }
    
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autocorrectionType
        return self
    }
    
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autocapitalizationType
        return self
    }
    
    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Self {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func clearsOnBeginEditing(_ isClear: Bool) -> Self {
        self.clearsOnBeginEditing = isClear
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ isAdjustFont: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = isAdjustFont
        return self
    }
    
    @discardableResult
    func minimumFontSize(_ minSize: CGFloat) -> Self {
        self.minimumFontSize = minSize
        return self
    }
    
    @discardableResult
    func background(_ image: UIImage?) -> Self {
        self.background = image
        return self
    }
    
    @discardableResult
    func disabledBackground(_ image: UIImage?) -> Self {
        self.disabledBackground = image
        return self
    }
    
    @discardableResult
    func clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }
    
    @discardableResult
    func leftView(_ view: UIView?) -> Self {
        self.leftView = view
        return self
    }
    
    @discardableResult
    func leftViewMode(_ mode: UITextField.ViewMode) -> Self {
        self.leftViewMode = mode
        return self
    }
    
    @discardableResult
    func rightView(_ view: UIView?) -> Self {
        self.rightView = view
        return self
    }
    
    @discardableResult
    func rightViewMode(_ mode: UITextField.ViewMode) -> Self {
        self.rightViewMode = mode
        return self
    }
    
    @discardableResult
    func inputView(_ view: UIView?) -> Self {
        self.inputView = view
        return self
    }
    
    @discardableResult
    func inputAccessoryView(_ view: UIView?) -> Self {
        self.inputAccessoryView = view
        return self
    }
}

public extension UITextView {
    
    @discardableResult
    func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func text(_ text: String!) -> Self {
        self.text = text;
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(fontSize: CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor?) -> Self {
        self.textColor = color;
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func selectedRange(_ selectedRange: NSRange) -> Self {
        self.selectedRange = selectedRange
        return self
    }
   
    @discardableResult
    func isEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }
    
    @discardableResult
    func isSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }
    
    @discardableResult
    func dataDetectorTypes(_ dataDetectorTypes: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = dataDetectorTypes
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Self {
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString!) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }
    
    @discardableResult
    func inputAccessoryView(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }
    
    @discardableResult
    func clearsOnInsertion(_ clearsOnInsertion: Bool) -> Self {
        self.clearsOnInsertion = clearsOnInsertion
        return self
    }
    
    @discardableResult
    func textContainerInset(_ textContainerInset: UIEdgeInsets) -> Self {
        self.textContainerInset = textContainerInset
        return self
    }
    
}

public extension UIScrollView {
    
    @discardableResult
    func contentOffset(_ offset: CGPoint) -> Self {
        self.contentOffset = offset
        return self
    }
    
    @discardableResult
    func contentOffset(_ x: CGFloat, _ y: CGFloat) -> Self {
        self.contentOffset = CGPoint(x: x, y: y);
        return self
    }
    
    @discardableResult
    func contentSize(_ size: CGSize) -> Self {
        self.contentSize = size
        return self
    }
    
    @discardableResult
    func contentSize(_ w: CGFloat, _ h: CGFloat) -> Self {
        self.contentSize = CGSize(width: w, height: h)
        return self
    }
    
    @discardableResult
    func contentInset(_ edgeInsets: UIEdgeInsets) -> Self {
        self.contentInset = edgeInsets
        return self
    }
    
    @discardableResult
    func contentInset(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        self.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @available(iOS 11.0, *)
    func contentInsetAdjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        self.contentInsetAdjustmentBehavior = behavior
        return self
    }
    
    @discardableResult
    func bounces(_ isBounces: Bool) -> Self {
        self.bounces = isBounces
        return self
    }
    
    @discardableResult
    func isDirectionalLockEnabled(_ isEnabled: Bool) -> Self {
        self.isDirectionalLockEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func alwaysBounceVertical(_ isAlways: Bool) -> Self {
        self.alwaysBounceVertical = isAlways
        return self
    }
    
    @discardableResult
    func alwaysBounceHorizontal(_ isAlways: Bool) -> Self {
        self.alwaysBounceHorizontal = isAlways
        return self
    }
    
    @discardableResult
    func isPagingEnabled(_ isEnabled: Bool) -> Self {
        self.isPagingEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isScrollEnabled(_ isEnabled: Bool) -> Self {
        self.isScrollEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func showsHorizontalScrollIndicator(_ isShow: Bool) -> Self {
        self.showsHorizontalScrollIndicator = isShow
        return self
    }
    
    @discardableResult
    func showsVerticalScrollIndicator(_ isShow: Bool) -> Self {
        self.showsVerticalScrollIndicator = isShow
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func scrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        self.scrollIndicatorInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func scrollIndicatorInsets(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        self.scrollIndicatorInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func indicatorStyle(_ style: UIScrollView.IndicatorStyle) -> Self {
        self.indicatorStyle = style
        return self
    }
    
    @discardableResult
    func decelerationRate(_ rate: CGFloat) -> Self {
        self.decelerationRate = UIScrollView.DecelerationRate(rawValue: rate)
        return self
    }
    
    @discardableResult
    func indexDisplayMode(_ mode: UIScrollView.IndexDisplayMode) -> Self {
        self.indexDisplayMode = mode
        return self
    }
    
    @discardableResult
    func delaysContentTouches(_ isDelays: Bool) -> Self {
        self.delaysContentTouches = isDelays
        return self
    }
    
    @discardableResult
    func canCancelContentTouches(_ isCanCancel: Bool) -> Self {
        self.canCancelContentTouches = isCanCancel
        return self
    }
    
    @discardableResult
    func minimumZoomScale(_ minScale: CGFloat) -> Self {
        self.minimumZoomScale = minScale
        return self
    }
    
    @discardableResult
    func maximumZoomScale(_ maxScale: CGFloat) -> Self {
        self.maximumZoomScale = maxScale
        return self
    }
    
    @discardableResult
    func zoomScale(_ scale: CGFloat) -> Self {
        self.zoomScale = scale
        return self
    }
    
    @discardableResult
    func bouncesZoom(_ isBouncesZoom: Bool) -> Self {
        self.bouncesZoom = isBouncesZoom
        return self
    }
    
    @discardableResult
    func scrollsToTop(_ isScrollsToTop: Bool) -> Self {
        self.scrollsToTop = isScrollsToTop
        return self
    }
    
    @discardableResult
    func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = mode
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        self.refreshControl = refreshControl
        return self
    }
}



