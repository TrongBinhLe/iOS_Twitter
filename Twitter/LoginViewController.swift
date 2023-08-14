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
    lazy var logoImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "TwitterLogo")
        return imageView
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.tintColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv  = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "mail")
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        return view
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.tintColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv  = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "ic_lock_outline_white_2x")
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        return view
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
        navigationController?.navigationBar.isHidden = true 
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        

        view.addSubview(stackContainLoginView)
        stackContainLoginView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}
