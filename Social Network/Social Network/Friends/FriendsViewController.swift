//
//  FriendsViewController.swift
//  Social Network
//
//  Created by Alex on 01.07.2021.
//
// Hello world

import UIKit
import RealmSwift
import Firebase

class FriendsViewController: UIViewController {
    

    
    private var apiservice = APIService()
    var friends: [FriendsModel] = []
    var user: RealmService?
    var token: NotificationToken?
    
    
    
    @IBOutlet weak var FriendTableView: UITableView! {
        
        didSet {
            FriendTableView.delegate = self
            FriendTableView.dataSource = self
            FriendTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendTableView")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        group.enter()
        apiservice.getFriend{ [weak self] users in
            guard let self = self else { return }
            self.friends = users
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.FriendTableView.reloadData()
        }
        
        let friend = user?.realm.objects(FriendsModel.self)
        
        user?.realm.add(friends)
        user?.realm.beginWrite()
        try? user?.realm.commitWrite()
        self.token = friend?.observe{ (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results ,deletions, insertions, modifications):
                print(results, deletions, insertions, modifications)
            case .error(let error):
                print(error)
            }
        }
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendTableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as! FriendsTableViewCell
        let user = friends[indexPath.row]
        cell.labelFriends.text = user.firstName ?? ""
        cell.secondNameLabel.text = user.lastName ?? ""
        cell.imageView?.sd_setImage(with: URL(string: user.photo ?? ""), placeholderImage: UIImage())
        
//        cell.textLabel?.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
//        cell.imageView?.sd_setImage(with: URL(string: user.photo ?? "" ), placeholderImage: UIImage())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = friends[indexPath.row]
        performSegue(withIdentifier: "goToProfile", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile" {
            let vc = segue.destination as! ProfileViewController
            guard let indexPath = FriendTableView.indexPathForSelectedRow else { return }
            let user = friends[indexPath.row]
            vc.profileFriends = user
        }
    }
    
}
