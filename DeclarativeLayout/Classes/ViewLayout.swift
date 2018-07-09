public class ViewLayout<T: UIView> {
    
    private let view: T
    private var currentLayoutComponent: UIViewLayoutComponent<T>
    private var currentSubviews = Set<UIView>()
    private var currentConstraints = HashSet<LayoutConstraint>()
    
    /**
     Initialize your view layout with the root view you are defining a layout for
     
     - parameters:
        - view: The root view you would like to define a layout for
     */
    public init(view: T) {
        self.view = view
        self.currentLayoutComponent = UIViewLayoutComponent(view: view)
    }
    
    /**
     Update your layout
     
     - parameters:
        - layoutClosure: A closure that will define the layout component for the ViewLayout's view
     */
    public func updateLayoutTo(_ layoutClosure: (UIViewLayoutComponent<T>, T) -> ()) {
        let layoutComponent = UIViewLayoutComponent(view: view)
        layoutClosure(layoutComponent, view)
        
        removeUnneededSubviews(with: layoutComponent)
        currentSubviews = Set<UIView>()
        addSubviews(with: layoutComponent)
        updateConstraints(with: layoutComponent)
        
        currentLayoutComponent = layoutComponent
    }
    
    private func addSubviews(with layoutComponent: UIViewLayoutComponentType) {
        for (i, subview) in layoutComponent.subviews.enumerated() {
            layoutComponent.downcastedView.insertSubview(subview, at: i)
            currentSubviews.insert(subview)
        }
        
        addSubviewsForSublayoutComponents(with: layoutComponent)
    }
    
    private func addSubviews(with layoutComponent: UIStackViewLayoutComponentType) {
        for (i, subview) in layoutComponent.subviews.enumerated() {
            layoutComponent.downcastedView.insertSubview(subview, at: i)
            currentSubviews.insert(subview)
        }
        
        addSubviewsForSublayoutComponents(with: layoutComponent)
    }
    
    private func addSubviewsForSublayoutComponents(with layoutComponent: ViewLayoutComponentType) {
        for sublayoutComponent in layoutComponent.sublayoutComponents {
            switch sublayoutComponent {
            case .uiview(let layoutComponent):
                addSubviews(with: layoutComponent)
            case .uistackview(let layoutComponent):
                addSubviews(with: layoutComponent)
                
                for (i, subview) in layoutComponent.arrangedSubviews.enumerated() {
                    layoutComponent.downcastedView.insertArrangedSubview(subview, at: i)
                }
                
                if #available(iOS 11.0, *) {
                    for customSpacing in layoutComponent.customSpacings {
                        layoutComponent.downcastedView.setCustomSpacing(customSpacing.space, after: customSpacing.afterView)
                    }
                }
            }
        }
    }
    
    private func removeUnneededSubviews(with layoutComponent: UIViewLayoutComponent<T>) {
        let layoutComponentSubviews = Set(layoutComponent.allSubviews())
        currentSubviews
            .filter { !layoutComponentSubviews.contains($0) }
            .forEach { $0.removeFromSuperview() }
    }
    
    private func updateConstraints(with layoutComponent: UIViewLayoutComponent<T>) {
        let newConstraints = layoutComponent.allConstraints()
        
        if currentConstraints.count > 0 {
            var constraintsToActivate = [NSLayoutConstraint]()
            var currentConstraintsToRemove = currentConstraints
            var newCachedConstraints = HashSet<LayoutConstraint>()
            for constraint in newConstraints {
                if let matchingConstraint = currentConstraints.get(constraint) {
                    currentConstraintsToRemove.remove(matchingConstraint)
                    newCachedConstraints.insert(matchingConstraint)
                    
                    if matchingConstraint.wrappedConstraint.constant != constraint.wrappedConstraint.constant {
                        matchingConstraint.wrappedConstraint.constant = constraint.wrappedConstraint.constant
                    }
                    
                    if matchingConstraint.wrappedConstraint.priority != constraint.wrappedConstraint.priority {
                        matchingConstraint.wrappedConstraint.priority = constraint.wrappedConstraint.priority
                    }
                    
                    if matchingConstraint.wrappedConstraint.identifier != constraint.wrappedConstraint.identifier {
                        matchingConstraint.wrappedConstraint.identifier = constraint.wrappedConstraint.identifier
                    }
                    
                    /*
                     In case they are using a library that activates the constraint as it is created,
                     it will deactivate it when not needed so there aren’t duplicate constraints laying around
                     */
                    constraint.wrappedConstraint.isActive = false
                } else {
                    newCachedConstraints.insert(constraint)
                    constraintsToActivate.append(constraint.wrappedConstraint)
                }
            }
            
            currentConstraints = newCachedConstraints
            
            let constraintsToRemove = currentConstraintsToRemove
                .allElements()
                .map { $0.wrappedConstraint }
            NSLayoutConstraint.deactivate(constraintsToRemove)
            NSLayoutConstraint.activate(constraintsToActivate)
        } else {
            NSLayoutConstraint.activate(newConstraints.map { $0.wrappedConstraint })
        }
    }
}
