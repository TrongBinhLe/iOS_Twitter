//
//  FeedViewController.swift
//  Twitter
//
//  Created by admin on 15/04/2024.
//


import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
    }
    
}
