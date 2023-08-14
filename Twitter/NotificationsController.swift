//
//  NotificationsController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import Foundation
import UIKit

class NotificationsController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Notifications"
        
    }
    
}
