//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

import SafariServices
import SnapKit
import UIKit

class DetailsViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    var scrollView = UIScrollView()
    
    var articles = [Article]()
    var data: NewsTableViewCellViewModel?
    var text = [NewsTableViewCellViewModel]()
    
    /// UI Elements
    let urlClick: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dataReliase: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    let buttonStar: UIButton = {
        let button = UIButton()
        let styleButton = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "star.fill", withConfiguration: styleButton)
        button.setImage(widthButton, for: .normal)
        button.tintColor = .quaternaryLabel //UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let arror: UIButton = {
        let button = UIButton()
        let styleButton = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        let widthButton = UIImage(systemName: "arrow.up.forward.app", withConfiguration: styleButton)
        button.setImage(widthButton, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    let arrorText: UIButton = {
        let button = UIButton()
        button.setTitle("Website", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    let newsSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let newsTitleDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        label.text = "Also"
        return label
    }()
    
    let newsDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViewDidLoad()
        setupAddSubviews()
        setupScrollView()
        setupDataFormatter()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.center = view.center
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        scrollView.contentSize = newsDescription.frame.size
        scrollView.showsVerticalScrollIndicator = false
        
        newsDescription.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: 0)
    }
    
    func setupAddSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(newsTitle)
        scrollView.addSubview(newsSubtitle)
        scrollView.addSubview(newsImage)
        scrollView.addSubview(dataReliase)
        scrollView.addSubview(arror)
        scrollView.addSubview(urlClick)
        scrollView.addSubview(arrorText)
        scrollView.addSubview(newsTitleDescription)
        scrollView.addSubview(newsDescription)
        scrollView.addSubview(buttonStar)
        
        arror.addTarget(self, action: #selector(targetButtonRepost), for: .touchUpInside)
        arrorText.addTarget(self, action: #selector(targetButtonRepost), for: .touchUpInside)
        buttonStar.addTarget(self, action: #selector(actionButtonStar), for: .touchUpInside)
    }
    
    func setupDataFormatter() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = data?.publishedAt
        let date = dateFormatter.date(from: dateString!)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let timeString = timeFormatter.string(from: date!)
        dataReliase.text = timeString
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataReliase.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(290)
        }
        
        newsTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(360)
        }
        
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(newsTitle.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(280)
        }
        
        buttonStar.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(340)
        }
        
        arror.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
        }
        
        arrorText.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(7)
            make.left.equalTo(arror.snp.left).inset(25)
        }
        
        newsSubtitle.snp.makeConstraints { make in
            make.top.equalTo(arror.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(360)
        }
        
        newsTitleDescription.snp.makeConstraints { make in
            make.top.equalTo(newsSubtitle.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(10)
        }
        
        newsDescription.snp.makeConstraints { make in
            make.top.equalTo(newsTitleDescription.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(360)
        }
        
        // Обновление contentSize для UIScrollView на основе размеров newsDescription
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: newsDescription.frame.maxY)
        addObjectOnView()
    }
    
    @objc func targetButtonRepost() {
        guard let url = URL(string: urlClick.text ?? "No url") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func actionButtonStar(_ sender: UIButton) {
        sender.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        let newsItem = NewsItem()
        newsItem.title = newsTitle.text!
        newsItem.descriptionText = newsSubtitle.text!
        newsItem.url = urlClick.text!
        if let image = newsImage.image,
           let imageData = image.jpegData(compressionQuality: 1.0) {
            newsItem.imageData = imageData
            RealmManager.shared.saveNewsItem(newsItem)
        } else {
            print("actionButtonStar image error")
        }
        RealmManager.shared.saveNewsItem(newsItem)
    }
    
    func addObjectOnView() {
        if let data = data {
            newsTitle.text = data.title
            newsSubtitle.text = data.subtitle
            urlClick.text = data.url
            newsDescription.text = data.content
            
            if let data = data.imageData {
                newsImage.image = UIImage(data: data)
            } else if let url = data.imageURL {
                
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.newsImage.image = UIImage(data: data)
                    }
                }.resume()
            } else {
                print("error вывод данных Second viewController")
            }
        }
    }
}
