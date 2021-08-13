//
//  NewsCodableViewController.swift
//  Social Network
//
//  Created by Alex on 08.08.2021.
//

import UIKit

class NewsCodableViewController: UIViewController {
    
    @IBOutlet weak var newsCodableTableView: UITableView!
    var feedItems: [Item] = []
    var feedProfiles: [Profile] = []
    var feedGroups: [Group] = []
    let apiService = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsCodableTableView.dataSource = self
        newsCodableTableView.delegate = self

        apiService.getNews { [weak self] feed in
            guard let self = self else { return }
            
            self.feedItems = feed!.response.items
            self.feedProfiles = feed!.response.profiles
            self.feedGroups = feed!.response.groups
            self.newsCodableTableView.reloadData()
            
        }
        
    }
    


}
extension NewsCodableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsCodableTableView.dequeueReusableCell(withIdentifier: "newsCodableCell", for: indexPath) as! NewsCodableTableViewCell
        let currentFeedItem = feedItems[indexPath.row]
        
        switch feedItems[indexPath.row].sourceID.signum() {
        
        case 1: // Пост пользователя
            let currentFeedItemProfile = feedProfiles.filter{ $0.id == currentFeedItem.sourceID }[0]
            cell.configure(item: currentFeedItem, profile: currentFeedItemProfile)
            
        case -1: // Пост группы
            let currentFeedItemGroup = feedGroups.filter{ $0.id == abs(currentFeedItem.sourceID ) }[0]
            cell.configure(item: currentFeedItem, group: currentFeedItemGroup)
            
        default: break
        }
        
        return cell
    }
    
    
}
