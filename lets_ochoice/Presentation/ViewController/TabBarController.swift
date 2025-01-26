import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create view controllers for each tab
        let detailViewController = MainViewController() // Example ID, you can pass your actual ID
        detailViewController.title = "Detail" // Set the title for the tab
        
        let anotherViewController = MyPageViewController() // Your other view controller
        anotherViewController.title = "Other"
        
        // Assign the view controllers to the tab bar controller
        self.viewControllers = [detailViewController, anotherViewController]
        
        // Customize Tab Bar appearance if needed
        let tabBarItems = self.tabBar.items
        tabBarItems?[0].image = UIImage(systemName: "film.fill")
        tabBarItems?[1].image = UIImage(systemName: "star.fill")
    }
}

