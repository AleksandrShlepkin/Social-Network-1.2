//
//  NewsMainClass.swift
//  Social Network
//
//  Created by Alex on 11.09.2021.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import WebKit




//MARK: Main View Controller
class MainNewsViewController: UIViewController {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        func sizeCell(_ item: Item) -> CGFloat {
            
            guard let height = item.attachments?[0].photo?.typePhoto?.height else { return UITableView.automaticDimension }
            guard let wight = item.attachments?[0].photo?.typePhoto?.width else { return
                UITableView.automaticDimension
            }
            let tableWight = tableView.bounds.width
            
            let aspectRatio = CGFloat(height) / CGFloat(wight)
            let cellHeigt = tableWight * aspectRatio
            return cellHeigt
            
            }
        return tableView.rowHeight
    }
    
    
    
    private var feedItems: [Item] = []
    private var feedProfiles: [Profile] = []
    private var feedGroups: [Group] = []
    
    
    var apiServise = NewsAPI()
    
    var isLoading: Bool = false
    var nextFrom: String = ""
    
    @IBOutlet weak var mainTableView: UITableView!
    let apiService = NewsAPI()
    
    

    let refreshControllet = UIRefreshControl()
    @objc func refresh(sender: AnyObject) {
        let lastNews = self.feedItems.first?.date ?? Date().timeIntervalSince1970
        apiService.getNews(startTime: lastNews + 1) { [weak self ] feed in
            guard let self = self else { return }
            self.refreshControllet.endRefreshing()
            guard let items = feed?.response.items else { return }
            guard let profiles = feed?.response.profiles else { return }
            guard let groups = feed?.response.groups else { return }
            
            self.feedItems = items + self.feedItems
            self.feedProfiles = profiles + self.feedProfiles
            self.feedGroups = groups + self.feedGroups
            
            let indexSet = IndexSet(integersIn: 0..<items.count )
            self.mainTableView.insertSections(indexSet, with: .automatic)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.prefetchDataSource = self
        
        refreshControllet.attributedTitle = NSAttributedString(string: "Щас будет что-то новенькое")
        refreshControllet.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        mainTableView.addSubview(refreshControllet)
        
        
        apiService.getNews { [weak self] feed in
            guard let self = self else { return }
            
            self.feedItems = feed!.response.items
            self.feedProfiles = feed!.response.profiles
            self.feedGroups = feed!.response.groups
            self.mainTableView.reloadData()
            
        }
    }
}



//MARK: Extention for Main View Controller
extension MainNewsViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return firstCell(indexPath: indexPath)
        case 1:
            return secondCell(indexPath: indexPath)
        case 2:
            return thirdCell(indexPath: indexPath)
        case 3:
            return fourCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func firstCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! FirstCell
        let currentItems = feedItems[indexPath.section]
        switch feedItems[indexPath.section].sourceID.signum() {
        case 1:
            let feedItemProfile = feedProfiles.filter{ $0.id == currentItems.sourceID }[0]
            cell.configure(profile: feedItemProfile, postDateFunc: currentItems.date)
            
        case -1:
            let feedItemGroup = feedGroups.filter{ $0.id == abs( currentItems.sourceID) }[0]
            cell.configure(group: feedItemGroup, postDateFunc: currentItems.date)
            
        default: break
            
        }
        
        return cell
    }
    
    func secondCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
        let currentItemsPhoto = feedItems[indexPath.section]
        cell.configure(url: currentItemsPhoto.attachments?[0].photo?.typePhoto?.url)
        
        return cell
        
    }
    
    func thirdCell(indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as! ThirdCell
        let currentItemText = feedItems[indexPath.section]
        
        cell.mainTextNews.text = currentItemText.text
        return cell
    }
    
    func fourCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "FourCell", for: indexPath) as! FourCell
        
        let currentItemsLike = feedItems[indexPath.section]
        cell.comentsCount.text = "\(currentItemsLike.comments?.count ?? 0)"
        cell.likeCount.text = "\(currentItemsLike.likes.count)"
        cell.repostCount.text = "\(currentItemsLike.reposts.count)"
        cell.viewsCount.text = "\(currentItemsLike.views?.count ?? 0) "
        
        return cell
    }
    
}

extension MainNewsViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > feedItems.count - 7, !isLoading {
            
            self.isLoading = true
            
            apiService.getNews(nextFrom: nextFrom) { [weak self] feed  in
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
                self.mainTableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false
            }
        }
    }
}
