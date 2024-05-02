//
//  UserService.swift
//  Twitter
//
//  Created by admin on 02/05/2024.
//

import Foundation
import Firebase

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            print("DEBUG: Snapshots: \(snapshot)")
            guard let dictionary = snapshot.value as? [String : AnyObject] else { return }
            
            guard let username = dictionary["userName"] as? String else { return }
            print("DEBUG: userName: \(username)")
        }
    }
}
