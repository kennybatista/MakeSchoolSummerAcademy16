import UIKit
import Parse




class TimelineVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var timelineTableView: UITableView!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    var posts : [Post] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        cell.gramImageView.image = posts[indexPath.row].image
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        What are we doing here? In viewDidLoad we are setting the TimelineVC to be the delegate of the tabBarController. Every UIViewController (which includes all subclasses) in iOS has the tabBarController? property; if the view controller is presented from a UITabBarViewController (as is the case in Makestagram), this property will store a reference to it.
        
    
        self.tabBarController?.delegate = self
    }
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
            let post = Post()
            post.image = image
            post.uploadPost()
        }
 

    }
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1
        let followingQuery = PFQuery(className: "Follow")
        followingQuery.whereKey("fromUser", equalTo:PFUser.currentUser()!)
        
        // 2
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
        
        // 3
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
        
        // 4
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        // 5
        query.includeKey("user")
        // 6
        query.orderByDescending("createdAt")
        
        // 7
        query.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            
            // 1

            for post in self.posts {
                do {
                    // 2
                    let data = try post.imageFile?.getData()
                    // 3
                    post.image = UIImage(data: data!, scale:1.0)
                } catch {
                    print("could not get image")
                }
            }
            
            self.timelineTableView.reloadData()
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


/*

 First create a PFFile with the image data, then a PFObject for the post. 
 Remember that the post needs a reference to the uploaded image! 
 Place your solution in the PhotoHelper callback within TimelineViewController. 
 
 You will need to use a function called UIImageJPEGRepresentation to convert the UIImage into NSData to be passed to the PFFile.
 */



