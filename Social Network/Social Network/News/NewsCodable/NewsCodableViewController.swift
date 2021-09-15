//
//  NewsCodableViewController.swift
//  Social Network
//
//  Created by Alex on 08.08.2021.
//

import UIKit

class NewsCodableViewController: UIViewController {
    
    let refreshControll = UIRefreshControl()
//    var photoNewss: [PhotoNew] = []
    
    @IBOutlet weak var newsCodableTableView: UITableView!
    private var feedItems: [Item] = []
    private var feedProfiles: [Profile] = []
    private var feedGroups: [Group] = []
    var apiServise = NewsAPI()
    
    var isLoading: Bool = false
    var nextFrom: String = ""
    
    
    
    //MARK: Функция обновления ленты новостей 
    @objc func refresh(sender: AnyObject){
        
        self.refreshControll.beginRefreshing()
        let lastNews = self.feedItems.first?.date ?? Date().timeIntervalSince1970
        
        apiServise.getNews(startTime: lastNews + 1) { [weak self] feed in
            guard let self = self else { return }
            self.refreshControll.endRefreshing()
            
            guard let items = feed?.response.items else { return }
            guard let profiles = feed?.response.profiles else { return }
            guard let groups = feed?.response.groups else { return }
            
            self.feedItems = items + self.feedItems
            self.feedProfiles = profiles + self.feedProfiles
            self.feedGroups = groups + self.feedGroups
            
            let indexSet = IndexSet(integersIn: 0..<items.count )
            self.newsCodableTableView.insertSections(indexSet, with: .automatic)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsCodableTableView.dataSource = self
        newsCodableTableView.delegate = self
        newsCodableTableView.prefetchDataSource = self
        
        refreshControll.attributedTitle = NSAttributedString(string: "pullToRefresh")
        refreshControll.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        newsCodableTableView.addSubview(refreshControll)
        
        
        
        
        apiServise.getNews { [weak self] feed in
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
            cell.configure(item: currentFeedItem, profile: currentFeedItemProfile, index: indexPath.row)
            
        case -1: // Пост группы
            let currentFeedItemGroup = feedGroups.filter{ $0.id == abs(currentFeedItem.sourceID ) }[0]
            cell.configure(item: currentFeedItem, group: currentFeedItemGroup, index: indexPath.row)
            
        default: break
        }
        
        return cell
    }
    
    
}
extension NewsCodableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        
        if maxSection > feedItems.count - 3, !isLoading {
            
            self.isLoading = true
            
            apiServise.getNews() { [weak self] feed  in
                guard let self = self else { return }
                
                guard let nextFrom = feed?.response.nextFrom else { return }
                
                self.nextFrom = nextFrom
                
                guard let items = feed?.response.items else { return }
                guard let profiles = feed?.response.profiles else { return }
                guard let groups = feed?.response.groups else { return }
                
                let indexSet = IndexSet(integersIn: self.feedItems.count ..< self.feedItems.count + items.count )
                
                self.feedItems.append(contentsOf: items)
                self.feedProfiles.append(contentsOf: profiles)
                self.feedGroups.append(contentsOf: groups)
                
                self.newsCodableTableView.insertSections(indexSet, with: .automatic)
                
                self.isLoading = false
            }
        }
    }
}
