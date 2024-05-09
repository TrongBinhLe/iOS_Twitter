//
//  TweetViewModel.swift
//  Twitter
//
//  Created by admin on 09/05/2024.
//

import Foundation
import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        tweet.user.profileImageUrl
    }
    
    var userInfoText: NSAttributedString {
        
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: "@\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
}

