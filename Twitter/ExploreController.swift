//
//  ExploreController.swift
//  Twitter
//
//  Created by admin on 14/08/2023.
//

import Foundation
import UIKit

private let userIndentifier = "UserCell"

class ExploreController: UITableViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: userIndentifier)
        tableView.separatorStyle = .none
        
    }
    
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userIndentifier, for: indexPath) as! UserCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
