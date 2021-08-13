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
    
    @IBOutlet weak var GroupsTableView: UITableView!
    
    private  var apiservice = APIService()
    private var groups: [GroupsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroupsTableView.delegate = self
        GroupsTableView.dataSource = self
        GroupsTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsTableViewCell")

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
        let cell = GroupsTableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as! GroupsTableViewCell
        let userGroups = groups[indexPath.row]
        cell.imageGroup.sd_setImage(with: URL(string: userGroups.photo ?? ""), placeholderImage: UIImage())
        cell.nameGroup.text = userGroups.name ?? ""
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        performSegue(withIdentifier: "goToGroup", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGroup" {
            let vc = segue.destination as! GroupProfileViewController
            guard let indexPath = GroupsTableView.indexPathForSelectedRow else {
                return
            }
            let group = groups[indexPath.row]
            vc.profileGroup2 = group
    }
    
}
}
