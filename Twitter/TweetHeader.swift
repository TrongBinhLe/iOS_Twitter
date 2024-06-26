//
//  TweetHeader.swift
//  Twitter
//
//  Created by admin on 25/06/2024.
//

import Foundation
import UIKit

class TweetHeader: UICollectionReusableView {
    //MARK: - Properties
    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .blue
//        return view
//    }()
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
//        addSubview(containerView)
//        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
