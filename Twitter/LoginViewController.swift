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
    
    lazy var emailTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Email")
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = Uitilities.textField(withPlaceHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var stackContainLoginView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 8.0
        return stack
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
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
        stackContainLoginView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}
