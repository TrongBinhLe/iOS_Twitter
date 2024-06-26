//
//  UploadTweetController.swift
//  Twitter
//
//  Created by admin on 07/05/2024.
//

import Foundation
import UIKit
 
class UploadTweetController: UIViewController {
    
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewmodel = UploadTweetViewModel(config: config)
    // MARK: - Properties
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for:.normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32/2
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 60, height: 60)
        iv.layer.cornerRadius = 60 / 2
        
        return iv
    }()
    
    private lazy var replyLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "replying to @spiderman"
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        return label
    }()
    
    private let captionTextView = CaptionTextView()
    // MARK: - Lifecyle
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        switch config {
        case .tweet:
            print("DEBUG: render tweet Ui")
        case .reply(let tweet):
            print("DEBUG: render Replying to \(tweet.caption)")
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configure() {
        view.backgroundColor = .white
        configureNavigationbar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .center
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12
        
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        actionButton.setTitle(viewmodel.actionButtonTitle, for: .normal)
        
        replyLabel.isHidden = !viewmodel.shouldShowReplyLabel
        guard let replyText = viewmodel.replyText else { return }
        replyLabel.text = replyText
        
    }
    
    func configureNavigationbar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel) )
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
}
