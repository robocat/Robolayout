# Robolayout

The default auto layout API is cumbersome to work with. At Robocat we made a few extensions to NSLayoutConstraint and UIView in order to make a tolerable auto layout API.

## Quick overview

Below is a quick overview of the API. Most of the methods should be self-explanatory. With the use of Swifts default parameters, the API become very concise but allow you to go into detail when needed.

**Directly setting width and height**

    setWidthEqual(constant: CGFloat)
    setHeightEqual(constant: CGFloat)
    setWidthEqual(view: UIView, multiplier: CGFloat = 1)
    setHeightEqual(view: UIView, multiplier: CGFloat = 1)
    
**Spacing to edges**

    setLeadingToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000)
    setTrailingToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000)
    setTopToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000)
    setBottomToSuperview(relation relation: NSLayoutRelation = .Equal, constant: CGFloat = 0, priority: UILayoutPriority = 1000)
    constraints(vertical vertical: String? = nil, horizontal: String? = nil, _ views: [String : UIView])

The last method lets you configure the constraints using a visual format.

**Centering**

    setCenterVerticallyInSuperview(constant constant: CGFloat = 0, priority: UILayoutPriority = 1000)
    setCenterHorizontallyInSuperview(constant constant: CGFloat = 0, priority: UILayoutPriority = 1000)

**Content hugging and compression resistance**

The following variables on instances of UIView lets you configure the content hugging and compression resistance.

    horizontalCompressionResistance
    verticalCompressionResistance
    horizontalHuggingPriority
    verticalHuggingPriority

## Going into detail

A lot of the time you will use the above methods. The below method lays out to views relative to each other.

    constraint(item: UIView, _ attribute: NSLayoutAttribute, _ relation: NSLayoutRelation, _ item2: UIView? = nil, _ attribute2: NSLayoutAttribute = .NotAnAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = 1000)

Sometimes you are interested in positioning views relative to the objects conforming to UILayoutSupport, e.g. `topLayoutGuide` and `bottomLayoutGuide` of UIViewController. In those cases you use the below method.

    constraintToLayoutSupport(item : UIView, _ attribute : NSLayoutAttribute, _ relation : NSLayoutRelation, _ item2 : UILayoutSupport, _ attribute2 : NSLayoutAttribute = .NotAnAttribute, multiplier : CGFloat = 1, constant : CGFloat = 0, priority : UILayoutPriority = 1000)

## Keeping references

All methods either return an instance or an array of NSLayoutConstraint, depending on whether a single or multiple constraints where added.

## translatesAutoresizingMaskIntoConstraints

Robolayout will always set `translatesAutoresizingMaskIntoConstraints` of any views associated with the operation to `false`. This is by design. In most cases you are interested in having the property set to false. However, in some cases it must be true. This includes but is not limited to the content view of instances of UIViewTableViewCell and UICollectionView and the root view of a UIViewController. Remember to manually set `translatesAutoresizingMaskIntoConstraints` to true in those cases.
