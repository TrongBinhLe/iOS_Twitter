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
                     "likes": 0,
                     "retweets": 0,
                     "caption": caption] as [String: Any]
        let ref = REF_TWEETS.childByAutoId()
        
        ref.updateChildValues(values) { error, ref in
            // update user-tweets structure after tweet upload completes
            guard let tweetID = ref.key else { return }
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID : 1], withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let userId = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: userId) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchTweets(forUser user: User, completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            
            let tweetID = snapshot.key
            print("DEBUG1: re_user_tweets \(snapshot)")
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                print("DEBUG1: _tweets \(snapshot)")
                
                UserService.shared.fetchUser(uid: uid) { user in
                    print("DEBUG1: fetchUser \(user)")
                    let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
                
            }
        }
    }
}
