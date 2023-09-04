//
//  MainViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

import EmptyDataSet_Swift
import SnapKit
import UIKit

class MainViewController: UIViewController {
    var selectedIndexPath: IndexPath?
    
    private let tableView = UITableView()
    let refreshControll = UIRefreshControl()
    let searchVC = UISearchController(searchResultsController: nil)
    
    private var viewModels = [NewsTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDidLoad()
        setupAddSubviews()
        setupTableView()
        fetchData()
    }
    
    func setupViewDidLoad() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        searchVC.searchBar.searchTextField.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func setupAddSubviews() {
        view.addSubview(tableView)
        refreshControll.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    func setupTableView() {
        tableView.refreshControl = refreshControll
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    /// fetchDataInTableView
    func fetchData() {
        APICallerAllNews.shared.getTopData { [weak self] result in
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No description",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt,
                        url: $0.url ?? "No url",
                        content: $0.content ?? "No description"
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailsViewController()
            detailViewController.data = viewModels[indexPath.row]

        detailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        APICallerAllNews.shared.searchGetData(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Subtitle",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt,
                        url: $0.url ?? "No url",
                        content: $0.content ?? "No description"
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        performSearch(with: "")
        searchBar.resignFirstResponder()
        
        fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(with: searchText)
    }
    
    func performSearch(with searchText: String) {
        fetchData()
    }
}

/// EmptyDataSetSource & EmptyDataSetDelegate
extension MainViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        let imageView = UIButton()
        imageView.setImage(UIImage(systemName: "circle.slash"), for: .normal)
        let styleButton = UIImage.SymbolConfiguration(pointSize: 70, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "circle.slash", withConfiguration: styleButton)
        imageView.tintColor = .quaternaryLabel
        imageView.setImage(widthButton, for: .normal)
        imageView.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        return imageView
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -160.0
    }
}

/// @objc funcs
extension MainViewController {
    @objc private func refreshAction() { fetchData() }
}
