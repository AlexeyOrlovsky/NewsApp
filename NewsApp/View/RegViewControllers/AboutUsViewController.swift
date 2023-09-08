//
//  AboutUsViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import SafariServices
import UIKit
import SnapKit
import SwiftUI

class AboutUsViewController: UIViewController {
    
    /// website URL
    let topHeadlinesURL = URL(string: "https://pranx.com/hacker/typer/")
    
    /// UI Elements
    let nameViewTitle: UILabel = {
        let label = UILabel()
        label.text = "About the application"
        label.font = .systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Our news application provides the user with relevant and interesting news from all over the world. With our application, you can keep up to date with the latest events related to politics, economics, science, sports and many other areas."
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let subtitle2: UILabel = {
        let label = UILabel()
        label.text = "We strive to provide our users with the best news reading experience by providing up-to-date and reliable news, diverse sources and a user-friendly interface. With our news app, you can keep up to date with what's happening in the world and never miss important information."
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let subtitle3: UILabel = {
        let label = UILabel()
        label.text = "Variety of Sources: We partner with a variety of well-known news sources to provide you with a wide variety of news from a variety of sources and perspectives."
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let buttonWebsite: UIButton = {
        let button = UIButton()
        button.setTitle("Website", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.backgroundColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDidLoad()
        setupAddSubviews()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        
        setupAddSubviews()
    }
    
    func setupAddSubviews() {
        view.addSubview(nameViewTitle)
        view.addSubview(subtitle)
        view.addSubview(subtitle2)
        view.addSubview(subtitle3)
        view.addSubview(buttonWebsite)
        
        buttonWebsite.addTarget(self, action: #selector(websiteButtonAction), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameViewTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(20)
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(nameViewTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        subtitle2.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        subtitle3.snp.makeConstraints { make in
            make.top.equalTo(subtitle2.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        buttonWebsite.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
            make.width.equalTo(165)
            make.height.equalTo(50)
        }
    }
}

/// @objc funcs
extension AboutUsViewController {
    @objc func websiteButtonAction() {
        guard let url = topHeadlinesURL else { return }

        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}
