//
//  GroupsViewController.swift
//  Social Network
//
//  Created by Alex on 01.07.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var GroupsTableView: UITableView!
    var groups:[ItemGroups] = []
    let apiService = GroupsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroupsTableView.delegate = self
        GroupsTableView.dataSource = self
        GroupsTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsTableViewCell")
        
        apiService.getGroups { [weak self ] groups in
            guard let self = self else { return }
            self.groups = groups.response.items
            self.GroupsTableView.reloadData()
        }

       
    }
}
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GroupsTableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as! GroupsTableViewCell
        let group = groups[indexPath.row]
        cell.nameGroup.text = group.name
        cell.imageGroup.sd_setImage(with: URL(string: group.photo100 ?? ""), placeholderImage: UIImage())
       
        return cell
    }
    
  
    

}
