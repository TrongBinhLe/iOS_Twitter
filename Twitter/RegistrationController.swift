//
//  RegistrationController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import Foundation
import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "mail")
        let view = Uitilities.inputContainerView(withImage: image, textField: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let view = Uitilities.inputContainerView(withImage: image, textField: passwordTextField)
        
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Email")
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let view = Uitilities.inputContainerView(withImage: image, textField: fullNameTextField)
        
        return view
    }()

    private lazy var userNameContainerView: UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let view = Uitilities.inputContainerView(withImage: image, textField: userNameTextField)
        
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Password")
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Full Name")
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Username")
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Uitilities.attributedButton("Already have an account! ", "Log In")
        button.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonRegister: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackContainLoginView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView, buttonRegister])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true)
    }
    
    @objc func handleRegistration() {
        guard let profileImage = profileImage else {
            print("DEBUG: Please select a profile image..")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let userName = userNameTextField.text else { return }
        
        // Compress the profile image
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
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
                Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                    guard let _ = self else { return }
                    if let error = error {
                        print("DEBUG: error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let userID = authResult?.user.uid else { return }
                    let values = ["email": email,
                                  "password": password,
                                  "fullName": fullName,
                                  "userName": userName,
                                  "profileImageUrl": profileImageURL]
                    
                    let ref = REF_USERS.child(userID)
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
    
    @objc func handleSignInButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        view.tintColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 120, height: 120)
        

        view.addSubview(stackContainLoginView)
        stackContainLoginView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 120/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true)
    }
}
