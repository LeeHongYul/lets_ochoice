import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tabBar.unselectedItemTintColor = .gray
        
        tabBar.tintColor = .red
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
       
        let detailViewController = MainViewController()
        detailViewController.title = "홈"
        
        let myPageViewController = MyPageViewController()
        myPageViewController.title = "VOD"
        
    
        self.viewControllers = [detailViewController, myPageViewController]
        
        // Customize Tab Bar appearance if needed
        let tabBarItems = self.tabBar.items
        tabBarItems?[0].image = UIImage(systemName: "house.fill")
        tabBarItems?[1].image = UIImage(systemName: "tv")
        }
}

