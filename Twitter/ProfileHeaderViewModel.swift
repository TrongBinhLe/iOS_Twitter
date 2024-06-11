//
//  ProfileHeaderViewModel.swift
//  Twitter
//
//  Created by admin on 11/06/2024.
//

import Foundation
import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}


