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
    
    @IBOutlet weak var newsTableView: UITableView!
    
    private var apiservice = APIService()
    private var new = [NewsSecond]()
    private var ref = Database.database().reference(withPath: "news/ \(Session.shared.userID)")
    var newsRealm: RealmService?
    var token: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        group.enter()
        apiservice.getNews { [weak self] news in
            guard let self = self else { return }
            self.new = news
            group.leave()
        }
        
//        setNews()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(UINib(nibName: "NewsSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsSecondTableViewCell")
        
    }
    
    func setNews() {
//        apiservice.getNews(completion: new)

        ref.observe(.value, with: { [weak self] snapshot in
            guard let self = self else { return }
            var news: [News] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let new = News(snapshot: snapshot) {
                    news.append(new)
                }
            }

//            self.new = news
            self.newsTableView.reloadData()
        })
    }
    
//    func getNews() {
//        apiservice.getNews()
//
//        ref.observe(.value, with: {[weak self ] snapshop in
//            guard self != nil else { return }
//            var news: [News] = []
//            for child in snapshop.children {
//                if let snapshop = child as? DataSnapshot,
//                   let new = News(snapshot: snapshop) {
//                    news.append(new)
//                }
//            }
//
//
//        })
//    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return new.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSecondTableViewCell", for: indexPath) as? NewsSecondTableViewCell else {
            return UITableViewCell()
        }
        let news = new[indexPath.row]
        cell.imageNews.sd_setImage(with: URL(string: news.photo ?? ""), placeholderImage: UIImage())
        cell.textNews.text = news.firstName ?? ""
        return cell
    }
    
    
}
