//
//  ProfileHeader.swift
//  Twitter
//
//  Created by admin on 10/06/2024.
//

import Foundation
import UIKit

class ProfileHeader: UICollectionReusableView {
        
    // MARK: - Propertiese
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
