//
//  LoginViewController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var logoImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "TwitterLogo")
        return imageView
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
    
    private lazy var passwordTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var buttonLogin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackContainLoginView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, buttonLogin])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Uitilities.attributedButton("Don't have account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            print("DEBUG: the email: \(email) and password: \(password)")
            if let error = error {
                print("DEBUG: Error loggin in \(error.localizedDescription)")
                return
            }
            let scense = UIApplication.shared.connectedScenes
            let windowScene = scense.first as? UIWindowScene
            
            guard let tab = windowScene?.keyWindow?.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleSignUpButton() {
        let registerViewController = RegistrationController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        view.tintColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        

        view.addSubview(stackContainLoginView)
        stackContainLoginView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    }
    
}
