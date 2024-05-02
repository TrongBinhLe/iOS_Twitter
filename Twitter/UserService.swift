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
            
            let user = User(uid: uid, dictionary: dictionary)
            print("DEBUG: userName: \(user.username)")
            print("DEBUG: fullName: \(user.fullname)")
            
        }
    }
}
