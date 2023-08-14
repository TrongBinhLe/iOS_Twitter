//
//  MainTabController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import UIKit

class MainTabController: UITabBarController {
        
    //MARK: - Properties
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }

    //MARK: - Helpers
    
    func configureViewControllers() {
        let feed = FeedController()
        let navFeed = templateNavigationController(image: UIImage(named: "home_unselected")!, viewController: feed)
        
        let explore = ExploreController()
        let navExplore = templateNavigationController(image: UIImage(named: "search_unselected")!, viewController: explore)
        
        let notifications = NotificationsController()
        let navNotifications = templateNavigationController(image: UIImage(named: "search_unselected")!, viewController: notifications)
        
        let conversation = ConversationController()
        let navConversation = templateNavigationController(image: UIImage(named: "search_unselected")!, viewController: conversation)
        
        viewControllers = [navFeed, navExplore, navNotifications, navConversation]
    }
    
    func templateNavigationController(image: UIImage, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
