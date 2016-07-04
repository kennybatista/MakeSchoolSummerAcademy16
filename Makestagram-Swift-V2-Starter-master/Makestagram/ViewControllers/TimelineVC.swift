import UIKit



class TimelineVC: UIViewController {
    
    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        What are we doing here? In viewDidLoad we are setting the TimelineVC to be the delegate of the tabBarController. Every UIViewController (which includes all subclasses) in iOS has the tabBarController? property; if the view controller is presented from a UITabBarViewController (as is the case in Makestagram), this property will store a reference to it.
        
    
        self.tabBarController?.delegate = self
    }
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
            print("received a callback")
        }
    }
}

// MARK: Tab Bar Delegate

//
//The protocol method requires us to return a boolean value. If we return true the tab bar will behave as usual and present the view controller that the user has selected. If we return false the view controller will not be displayed - exactly the behavior that we want for the Photo Tab Bar Item.
//Within the protocol method, we check which view controller is about to be selected. If the view controller is a PhotoViewController we return false and print "Take Photo" to the console. Later we'll replace this line with the actual photo taking code.
//If the view controller isn't a PhotoViewController, we return true and let the tab bar controller behave as usual.

extension TimelineVC: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoVC) {
            takePhoto()
            print("Take Photo")
            //false so it won't behave like the usual tab bar item and present the normal VC, because later on we want it to present a menu to take pictue instead.
            return false
        } else {
            return true
        }
    }
}