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
        guard let userName = userNameTextField.text?.lowercased() else { return }
        
        let credentails = AuthCredential(email: email, password: password, fullname: fullName, username: userName, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentails) { [weak self] (error, ref) in
            guard let self = self else { return }
            
            
            let scense = UIApplication.shared.connectedScenes
            let windowScene = scense.first as? UIWindowScene
            
            guard let tab = windowScene?.keyWindow?.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)

            print("DEBUG: Sign up successfull...")
            print("DEBUG: Handle update user interface here...")
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

    // MARK: - UIImagePickerControllerDelegate and 
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
