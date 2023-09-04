//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

import SnapKit
import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    func setImage(_ imageData: Data?) {
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            newsImage.image = image
        } else {
            print("No image")
        }
    }
    
    let dateFormatter = DateFormatter()
    var data: NewsTableViewCellViewModel?
    
    /// UI Elements
    let urlClick: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var newsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    var newsSubtitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 6
        return label
    }()
    
    private let dataReliase: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    var newsImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsSubtitle)
        contentView.addSubview(newsImage)
        contentView.addSubview(dataReliase)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(220)
            make.height.equalTo(40)
        }
        
        newsSubtitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(220)
            make.height.equalTo(120)
        }
        
        dataReliase.snp.makeConstraints { make in
            make.right.equalTo(newsImage.snp.left).inset(-10)
            make.bottom.equalToSuperview().inset(5)
        }
        
        newsImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(140)
            make.height.equalTo(140)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTitle.text = nil
        newsSubtitle.text = nil
        newsImage.image = nil
        dataReliase.text = nil
        urlClick.text = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitle.text = viewModel.title
        newsSubtitle.text = viewModel.subtitle
        dataReliase.text = viewModel.publishedAt
        
        /// DateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = viewModel.publishedAt
        guard let date = dateFormatter.date(from: dateString ?? "") else { return }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: date)
        
        dataReliase.text = timeString
        urlClick.text = viewModel.url
        
        
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

