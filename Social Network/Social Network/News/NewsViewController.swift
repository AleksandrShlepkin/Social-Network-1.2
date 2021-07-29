//
//  NewsViewController.swift
//  Social Network
//
//  Created by Alex on 23.07.2021.
//

import UIKit
import Firebase
import SDWebImage
import RealmSwift

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!{
        didSet{
            newsTableView.dataSource = self
            newsTableView.delegate = self
            newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        }
    }
    private var apiservice = APIService()
        var new = [News]()
    private var ref = Database.database().reference(withPath: "news/ \(Session.shared.userID)")
    var newsRealm: RealmService?
    var token: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    getNews()
    }
    
    func setNews() {
        apiservice.getNews()
        
        ref.observe(.value, with: { [weak self] snapshot in
            guard let self = self else { return }
            var news: [News] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let new = News(snapshot: snapshot) {
                       news.append(new)
                }
            }
            
            self.new = news
            self.newsTableView.reloadData()
        })
    }
    
    func getNews() {
        apiservice.getNews()

        ref.observe(.value, with: {[weak self ] snapshop in
            guard self != nil else { return }
            var news: [News] = []
            for child in snapshop.children {
                if let snapshop = child as? DataSnapshot,
                   let new = News(snapshot: snapshop) {
                    news.append(new)
                }
            }

        })
    }
}
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return new.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let news = new[indexPath.row]
        
        cell.config(news: news)
        return cell
    }
    
    
}
