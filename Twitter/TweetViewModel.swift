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
    
    // MARK: - Properties
    var profileImageUrl: URL? {
        tweet.user.profileImageUrl
    }
    
    var userInfoText: NSAttributedString {
        
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: "@\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ☼ \(timestamp).", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
            
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    //MARK: - Lifecyle
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
}

