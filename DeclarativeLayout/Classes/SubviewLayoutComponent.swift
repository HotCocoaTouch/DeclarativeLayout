import UIKit

public class SubviewLayoutComponent<T: UIView, R: UIView>: ViewLayoutComponent<T> {
    
    /**
     The component's view's superview
     */
    public let superview: R
    
    init(view: T,
         superview: R,
         collectionDelegate: ConstraintAndViewCollectionDelegate?)
    {
        self.superview = superview
        
        super.init(view: view)
        
        self.collectionDelegate = collectionDelegate
    }

}
