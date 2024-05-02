//
//  AuthService.swift
//  Twitter
//
//  Created by admin on 02/05/2024.
//

import Foundation
import Firebase

struct AuthCredential {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}
 
struct AuthService {
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredential, completion: @escaping(Error?,DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        
        // Compress the profile image
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        
        // Create and save the profile image in storage of firebase
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            print("DEBUG: Enter to the putData function ")
            if let error = error {
                print("DEBUG: putdata image return \(String(describing: error.localizedDescription))")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("DEBUG: Error when dowloadURL \(String(describing: error))")
                    return
                }
                print("DEBUG: Entry the dowloadURL with \(String(describing: url))")
                guard let profileImageURL = url?.absoluteString else { return }
                
                print("DEBUG: Email: \(email) and password: \(password)")
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

                    if let error = error {
                        print("DEBUG: error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let userID = authResult?.user.uid else { return }
                    let values = ["email": email,
                                  "password": password,
                                  "fullName": fullname,
                                  "userName": username,
                                  "profileImageUrl": profileImageURL]
                    
                    let ref = REF_USERS.child(userID)
                    
                    ref.updateChildValues(values, withCompletionBlock: completion)
                    ref.updateChildValues(values) { (erorr, ref) in
                        if let error = error {
                            print("DEBUG: error \(error.localizedDescription)")
                        }
                        print("DEBUG: Successfully updated user infomation...")
                    }
                    
                }
                
            }
        }
    }
}
