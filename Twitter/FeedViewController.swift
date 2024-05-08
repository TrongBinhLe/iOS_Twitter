//
//  FeedViewController.swift
//  Twitter
//
//  Created by admin on 15/04/2024.
//


import Foundation
import UIKit
import SDWebImage

class FeedViewController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            print("DEBUG: Did set user in feed controller....")
            configureLeftBarButton()
        }
    }
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchTweets()
    }
    
    //MARK: - API
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
         print("DEBUG: Tweets is \(tweets)")
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        guard let profileImageUrl = user.profileImageUrl else { return }
        profileImageView.sd_setImage(with: profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}
