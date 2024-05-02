//
//  MainTabController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
        
    //MARK: - Properties
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
//        logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    //MARK: - API

    func fetchUser() {
        UserService.shared.fetchUser()
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Did log user out .... ")
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }

    //MARK: - Selectors
    @objc func actionButtonTapped() {
        print("32323")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
//        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
//        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
//        actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17).isActive = true
//        actionButton.layer.cornerRadius = 56/2
        
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 15, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
        actionButton.layer.masksToBounds = true
    }
    
    func configureViewControllers() {
        let feed = FeedViewController()
        let navFeed = templateNavigationController(image: UIImage(named: "home_unselected")!, viewController: feed)
        
        let explore = ExploreController()
        let navExplore = templateNavigationController(image: UIImage(named: "search_unselected")!, viewController: explore)
        
        let notifications = NotificationsController()
        let navNotifications = templateNavigationController(image: UIImage(named: "like_unselected")!, viewController: notifications)
        
        let conversation = ConversationController()
        let navConversation = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1")!, viewController: conversation)
        
        viewControllers = [navFeed, navExplore, navNotifications, navConversation]
    }
    
    func templateNavigationController(image: UIImage, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
