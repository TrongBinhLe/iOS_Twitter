//
//  RegistrationController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import Foundation
import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
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
        return textField
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Full Name")
        return textField
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Username")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Uitilities.attributedButton("Already have an account! ", "Log In")
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
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
        
    }
    
    @objc func handleRegistration() {
        
    }
    
    @objc func handleSignUpButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        view.tintColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 100, height: 100)
        

        view.addSubview(stackContainLoginView)
        stackContainLoginView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    }
}
