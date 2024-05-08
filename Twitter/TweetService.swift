//
//  TweetService.swift
//  Twitter
//
//  Created by admin on 08/05/2024.
//

import Foundation
import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid" : uid,
                     "timestamp": Int(NSDate().timeIntervalSince1970),
                     "like": 0,
                     "retweet": 0,
                     "caption": caption] as [String: Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        
    }
}
