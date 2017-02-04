//
//  AutoLayout.swift
//  Roboshop
//
//  Created by Simon Støvring on 08/06/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    convenience init(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) {
        self.init(item: item, attribute: attribute, relatedBy: relation, toItem: item2, attribute: attribute2, multiplier: multiplier, constant: constant)
    }
    
}

public extension UIView {
    
    public var horizontalCompressionResistance: Float {
        set { setContentCompressionResistancePriority(newValue, for: .horizontal) }
        get { return contentCompressionResistancePriority(for: .horizontal) }
    }
        
    public var verticalCompressionResistance: Float {
        set { setContentCompressionResistancePriority(newValue, for: .vertical) }
        get { return contentCompressionResistancePriority(for: .vertical) }
    }
    
    public var horizontalHuggingPriority: Float {
        set { setContentHuggingPriority(newValue, for: .horizontal) }
        get { return contentHuggingPriority(for: .horizontal) }
    }
    
    public var verticalHuggingPriority: Float {
        set { setContentHuggingPriority(newValue, for: .vertical) }
        get { return contentHuggingPriority(for: .vertical) }
    }
    
    @discardableResult
    public func constraints(vertical: String? = nil, horizontal: String? = nil, options: NSLayoutFormatOptions = [], _ views: [String : UIView]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if let v = vertical {
            constraints += addConstraints(with: "V:\(v)", options: options, views: views)
        }
        
        if let h = horizontal {
            constraints += addConstraints(with: "H:\(h)", options: options, views: views)
        }
        
        for (_, view) in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return constraints
    }
    
    fileprivate func addConstraints(with format: String, options: NSLayoutFormatOptions = [], views: [String: UIView]) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: nil, views: views)
        addConstraints(constraints)
        return constraints as NSArray as! [NSLayoutConstraint]
    }
    
    @discardableResult
    public func setLeadingToSuperview(_ relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(.leading, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setTrailingToSuperview(_ relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(.trailing, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setTopToSuperview(_ relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(.top, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setBottomToSuperview(_ relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(.bottom, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setCenterVerticallyInSuperview(_ constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint {
        return setAttributeToSuperview(.centerY, relation: .equal, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setCenterHorizontallyInSuperview(_ constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint {
        return setAttributeToSuperview(.centerX, relation: .equal, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setCenterInSuperview(_ offset: CGPoint = CGPoint.zero, priority: UILayoutPriority = 1000) -> [NSLayoutConstraint] {
        return [
            setCenterHorizontallyInSuperview(offset.x, priority: priority),
            setCenterVerticallyInSuperview(offset.y, priority: priority)
        ]
    }
    
    @discardableResult
    public func setEdgesEqualToSuperview(insets: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        return superview!.constraints(
            vertical: "|-(\(insets.top))-[view]-(\(insets.bottom))-|",
            horizontal: "|-(\(insets.left))-[view]-(\(insets.right))-|",
            [ "view": self ])
    }
    
    @discardableResult
    public func setEdgesEqualToSiblingView(_ siblingView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(constraint(self, .top, .equal, siblingView, .top, constant: insets.top))
        constraints.append(constraint(self, .bottom, .equal, siblingView, .bottom, constant: insets.bottom))
        constraints.append(constraint(self, .leading, .equal, siblingView, .leading, constant: insets.left))
        constraints.append(constraint(self, .trailing, .equal, siblingView, .trailing, constant: insets.right))
        
        return constraints
    }
    
    fileprivate func setAttributeToSuperview(_ attribute: NSLayoutAttribute, relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return superview!.constraint(self, attribute, relation, superview!, attribute, multiplier: 1, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func setWidthEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        return superview!.constraint(self, .width, .equal, constant: constant)
    }
    
    @discardableResult
    public func setHeightEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        return superview!.constraint(self, .height, .equal, constant: constant)
    }
    
    @discardableResult
    public func setWidthEqual(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return superview!.constraint(self, .width, .equal, view, .width, multiplier: multiplier)
    }
    
    @discardableResult
    public func setHeightEqual(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return superview!.constraint(self, .height, .equal, view, .height, multiplier: multiplier)
    }
    
    @discardableResult
    public func constraint(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UIView? = nil, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.translatesAutoresizingMaskIntoConstraints = false
        item2?.translatesAutoresizingMaskIntoConstraints = false
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    @discardableResult
    public func constraintToLayoutSupport(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UILayoutSupport, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.translatesAutoresizingMaskIntoConstraints = false
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    @discardableResult
    fileprivate func constraintUsing(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
}

