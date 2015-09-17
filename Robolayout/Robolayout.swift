//
//  AutoLayout.swift
//  Roboshop
//
//  Created by Simon Støvring on 08/06/15.
//  Copyright (c) 2015 Robocat. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    convenience init(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) {
        self.init(item: item, attribute: attribute, relatedBy: relation, toItem: item2, attribute: attribute2, multiplier: multiplier, constant: constant)
    }
    
}

public extension UIView {
    
    public var horizontalCompressionResistance: Float {
        set { setContentCompressionResistancePriority(newValue, forAxis: .Horizontal) }
        get { return contentCompressionResistancePriorityForAxis(.Horizontal) }
    }
        
    public var verticalCompressionResistance: Float {
        set { setContentCompressionResistancePriority(newValue, forAxis: .Vertical) }
        get { return contentCompressionResistancePriorityForAxis(.Vertical) }
    }
    
    public var horizontalHuggingPriority: Float {
        set { setContentHuggingPriority(newValue, forAxis: .Horizontal) }
        get { return contentHuggingPriorityForAxis(.Horizontal) }
    }
    
    public var verticalHuggingPriority: Float {
        set { setContentHuggingPriority(newValue, forAxis: .Vertical) }
        get { return contentHuggingPriorityForAxis(.Vertical) }
    }
    
    public func constraints(vertical vertical: String? = nil, horizontal: String? = nil, options: NSLayoutFormatOptions = [], _ views: [String : UIView]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if let v = vertical {
            constraints += addConstraintsWithFormat("V:\(v)", options: options, views: views)
        }
        
        if let h = horizontal {
            constraints += addConstraintsWithFormat("H:\(h)", options: options, views: views)
        }
        
        for (_, view) in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return constraints
    }
    
    private func addConstraintsWithFormat(format: String, options: NSLayoutFormatOptions = [], views: [String: UIView]) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: nil, views: views)
        addConstraints(constraints)
        return constraints as NSArray as! [NSLayoutConstraint]
    }
    
    public func setLeadingToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .Leading, relation: relation, constant: constant, priority: priority)
    }
    
    public func setTrailingToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .Trailing, relation: relation, constant: constant, priority: priority)
    }
    
    public func setTopToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .Top, relation: relation, constant: constant, priority: priority)
    }
    
    public func setBottomToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .Bottom, relation: relation, constant: constant, priority: priority)
    }
    
    public func setCenterVerticallyInSuperview(constant constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint {
        return setAttributeToSuperview(attribute: .CenterY, relation: .Equal, constant: constant, priority: priority)
    }
    
    public func setCenterHorizontallyInSuperview(constant constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint {
        return setAttributeToSuperview(attribute: .CenterX, relation: .Equal, constant: constant, priority: priority)
    }
    
    public func setCenterInSuperview(offset: CGPoint = CGPointZero, priority: UILayoutPriority = 1000) -> [NSLayoutConstraint] {
        return [
            setCenterHorizontallyInSuperview(constant: offset.x, priority: priority),
            setCenterVerticallyInSuperview(constant: offset.y, priority: priority)
        ]
    }
    
    public func setEdgesEqualToSuperview(insets: UIEdgeInsets = UIEdgeInsetsZero) -> [NSLayoutConstraint] {
        return superview!.constraints(
            vertical: "|-\(insets.top)-[view]-\(insets.bottom)-|",
            horizontal: "|-\(insets.left)-[view]-\(insets.right)-|",
            [ "view": self ])
    }
    
    private func setAttributeToSuperview(attribute attribute: NSLayoutAttribute, relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return superview!.constraint(self, attribute, relation, superview!, attribute, multiplier: 1, constant: constant, priority: priority)
    }
    
    public func setWidthEqual(constant: CGFloat) -> NSLayoutConstraint {
        return superview!.constraint(self, .Width, .Equal, constant: constant)
    }
    
    public func setHeightEqual(constant: CGFloat) -> NSLayoutConstraint {
        return superview!.constraint(self, .Height, .Equal, constant: constant)
    }
    
    public func setWidthEqual(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return superview!.constraint(self, .Width, .Equal, view, .Width, multiplier: multiplier)
    }
    
    public func setHeightEqual(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return superview!.constraint(self, .Height, .Equal, view, .Height, multiplier: multiplier)
    }
    
    public func constraint(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UIView? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.translatesAutoresizingMaskIntoConstraints = false
        item2?.translatesAutoresizingMaskIntoConstraints = false
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    public func constraintToLayoutSupport(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UILayoutSupport, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.translatesAutoresizingMaskIntoConstraints = false
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    private func constraintUsing(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
}

