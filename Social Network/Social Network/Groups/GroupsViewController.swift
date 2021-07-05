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
    let config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    @IBOutlet weak var GroupsTableView: UITableView!{
        didSet {
            GroupsTableView.delegate = self
            GroupsTableView.dataSource = self
            GroupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupsTableView")
        }
    }
    private  var apiservice = APIService()
    private var groups: [GroupsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        group.enter()
        apiservice.getGroup { [weak self] usersGroups in
            guard let self = self else { return }
            self.groups = usersGroups
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.GroupsTableView.reloadData()
            
        }
        do {
            self.realm.beginWrite()
            self.realm.add(groups)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
}
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GroupsTableView.dequeueReusableCell(withIdentifier: "GroupsTableView", for: indexPath)
        let userGroups = groups[indexPath.row]
        cell.textLabel?.text = "\(userGroups.name ?? "")"
        cell.imageView?.sd_setImage(with: URL(string: userGroups.photo ?? ""), placeholderImage: UIImage())
        return cell
    }
    
    
}
