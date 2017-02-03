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
    
    public func constraints(vertical: String? = nil, horizontal: String? = nil, options: NSLayoutFormatOptions = [], _ views: [String : UIView]) -> [NSLayoutConstraint] {
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
    
    fileprivate func addConstraintsWithFormat(_ format: String, options: NSLayoutFormatOptions = [], views: [String: UIView]) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: nil, views: views)
        addConstraints(constraints)
        return constraints as NSArray as! [NSLayoutConstraint]
    }
    
    public func setLeadingToSuperview(relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .leading, relation: relation, constant: constant, priority: priority)
    }
    
    public func setTrailingToSuperview(relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .trailing, relation: relation, constant: constant, priority: priority)
    }
    
    public func setTopToSuperview(relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .top, relation: relation, constant: constant, priority: priority)
    }
    
    public func setBottomToSuperview(relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return setAttributeToSuperview(attribute: .bottom, relation: relation, constant: constant, priority: priority)
    }
    
    public func setCenterVerticallyInSuperview(constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint {
        return setAttributeToSuperview(attribute: .centerY, relation: .equal, constant: constant, priority: priority)
    }
    
    public func setCenterHorizontallyInSuperview(constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint {
        return setAttributeToSuperview(attribute: .centerX, relation: .equal, constant: constant, priority: priority)
    }
    
    public func setCenterInSuperview(_ offset: CGPoint = CGPoint.zero, priority: UILayoutPriority = 1000) -> [NSLayoutConstraint] {
        return [
            setCenterHorizontallyInSuperview(constant: offset.x, priority: priority),
            setCenterVerticallyInSuperview(constant: offset.y, priority: priority)
        ]
    }
    
    public func setEdgesEqualToSuperview(_ insets: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        return superview!.constraints(
            vertical: "|-(\(insets.top))-[view]-(\(insets.bottom))-|",
            horizontal: "|-(\(insets.left))-[view]-(\(insets.right))-|",
            [ "view": self ])
    }
    
    public func setEdgesEqualToSiblingView(_ siblingView: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(constraint(self, .top, .equal, siblingView, .top, constant: insets.top))
        constraints.append(constraint(self, .bottom, .equal, siblingView, .bottom, constant: insets.bottom))
        constraints.append(constraint(self, .leading, .equal, siblingView, .leading, constant: insets.left))
        constraints.append(constraint(self, .trailing, .equal, siblingView, .trailing, constant: insets.right))
        
        return constraints
    }
    
    fileprivate func setAttributeToSuperview(attribute: NSLayoutAttribute, relation: NSLayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000) -> NSLayoutConstraint  {
        return superview!.constraint(self, attribute, relation, superview!, attribute, multiplier: 1, constant: constant, priority: priority)
    }
    
    public func setWidthEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        return superview!.constraint(self, .width, .equal, constant: constant)
    }
    
    public func setHeightEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        return superview!.constraint(self, .height, .equal, constant: constant)
    }
    
    public func setWidthEqual(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return superview!.constraint(self, .width, .equal, view, .width, multiplier: multiplier)
    }
    
    public func setHeightEqual(_ view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return superview!.constraint(self, .height, .equal, view, .height, multiplier: multiplier)
    }
    
    public func constraint(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UIView? = nil, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.translatesAutoresizingMaskIntoConstraints = false
        item2?.translatesAutoresizingMaskIntoConstraints = false
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    public func constraintToLayoutSupport(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UILayoutSupport, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        item.translatesAutoresizingMaskIntoConstraints = false
        return constraintUsing(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant, priority: priority)
    }
    
    fileprivate func constraintUsing(_ item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : AnyObject? = nil, _ attribute2 : NSLayoutAttribute = .notAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item, attribute, relation, item2, attribute2, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
}

