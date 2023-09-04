//
//  Library.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import SafariServices
import EmptyDataSet_Swift
import SnapKit
import UIKit
import RealmSwift

class LibraryViewController: UIViewController {
    
    /// UI Elements
    let urlClick: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var newsItem: NewsItem?
    var data: NewsTableViewCellViewModel?
    var tableView = UITableView()
    private var savedNews: Results<NewsItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableView()
        addObjectOnView()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Library"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 150
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    func deleteNewsItem(_ item: NewsItem) {
        RealmManager.shared.deleteNewsItem(item)
    }
    
    func addObjectOnView() {
        if let data = data {
            urlClick.text = data.url
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedNews = RealmManager.shared.getSavedNewsItems()
        tableView.reloadData()
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError() }
        
        let newsItem = savedNews[indexPath.row]
        cell.newsTitle.text = newsItem.title
        cell.newsSubtitle.text = newsItem.descriptionText
        cell.urlClick.text = newsItem.url
        cell.setImage(newsItem.imageData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let newsItem = savedNews[indexPath.row]
            deleteNewsItem(newsItem)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newsItem = savedNews[indexPath.row]
        guard let url = URL(string: newsItem.url) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

extension LibraryViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        let imageView = UIImageView(image: UIImage(systemName: "star.square.on.square.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.tintColor = UIColor.quaternaryLabel
        return imageView
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -80.0
    }
}

