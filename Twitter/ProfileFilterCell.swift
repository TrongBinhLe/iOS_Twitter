//
//  ProfileFilterCell.swift
//  Twitter
//
//  Created by admin on 11/06/2024.
//

import Foundation
import UIKit

class ProfileFilterCell: UICollectionViewCell {

    //MARK: - Properties
    private let titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "text label"
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLable.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLable.textColor = isSelected ? UIColor.twitterBlue : UIColor.lightGray
        }
    }
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLable)
        titleLable.center(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selectors
    
    //MARK: - Helpers
}
