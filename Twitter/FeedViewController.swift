//
//  FeedViewController.swift
//  Twitter
//
//  Created by admin on 15/04/2024.
//


import Foundation
import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

class FeedViewController: UICollectionViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            print("DEBUG: Did set user in feed controller....")
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet { collectionView.reloadData() }
    }
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - API
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
            print("DEBUG: number of tweetsis \(tweets.count)")
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controler = TweetController(tweet: tweets[indexPath.row])
            navigationController?.pushViewController(controler, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewmodel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewmodel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 85)
    }
}

// MARK: -TweetCellDelegate

extension FeedViewController: TweetCellDelegate {
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controler = ProfileController(user: user)
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func handleReplyTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        guard let user = user else { return }
        var controller = UploadTweetController(user: tweet.user, config: .reply(tweet))
        if tweet.user.isCurrentUser {
            controller = UploadTweetController(user: tweet.user, config: .tweet)
        }
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
