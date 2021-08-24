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

class FriendsViewController: UIViewController  {
    
    private var apiservice = FriendsAPI()
    var friends: [ItemFriends] = []
    var user: RealmService?
    var token: NotificationToken?
    
    @IBOutlet weak var FriendTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendTableView.delegate = self
        FriendTableView.dataSource = self
        FriendTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendTableView")
        
        apiservice.getFriends { [weak self] user in
            guard let self = self else { return }
            
            self.friends = user!.response.items
            
            self.FriendTableView.reloadData()
            
        }
}
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendTableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendsTableViewCell
        
        let users = friends[indexPath.row]
        
        cell.labelFriends.text = users.firstName
        cell.imageFriend.sd_setImage(with: URL(string: users.photo100), placeholderImage: UIImage())
        
        if users.online == 0 {
            cell.onlineButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.onlineLabel.text = "Offline"
        } else {
            cell.onlineButton.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                cell.onlineLabel.text = "Online"
        }
        
        return cell
        
    }
    
    
    
}
