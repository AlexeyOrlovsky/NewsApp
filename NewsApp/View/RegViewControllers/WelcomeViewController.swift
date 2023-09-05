//
//  WelcomeViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import SnapKit
import SwiftUI
import UIKit

class WelcomeViewController: UIViewController {
    
    /// UI Elements
    let labelWelcome: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = .systemFont(ofSize: 30, weight: .black)
        return label
    }()
    
    let labelWelInfo: UILabel = {
        let label = UILabel()
        label.text = "With our application, you can keep up to date with the latest developments related to management, economics, science, sports and many other areas."
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let buttonLogin: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 20
        return button
    }()
    
    let buttonCreate: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.setTitle("Create account", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 20
        return button
    }()
    
    let buttonAboutUs: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.setTitle("About the application", for: .normal)
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViewDidLoad()
        setupAddSubviews()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
    }
    
    func setupAddSubviews() {
        view.addSubview(labelWelcome)
        view.addSubview(labelWelInfo)
        view.addSubview(buttonLogin)
        view.addSubview(buttonCreate)
        view.addSubview(buttonAboutUs)
        
        buttonLogin.addTarget(self, action: #selector(pressButtonLogin), for: .touchUpInside)
        buttonCreate.addTarget(self, action: #selector(pressButtonCreate), for: .touchUpInside)
        buttonAboutUs.addTarget(self, action: #selector(pressButtonAboutUs), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        labelWelcome.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(160)
        }
        
        labelWelInfo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
            make.width.equalTo(300)
        }
        
        buttonLogin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(170)
            make.width.equalTo(340)
            make.height.equalTo(60)
        }
        
        buttonCreate.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(340)
            make.height.equalTo(60)
        }
        
        buttonAboutUs.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
            make.width.equalTo(340)
            make.height.equalTo(60)
        }
    }
}

/// @objc funcs
extension WelcomeViewController {
    
    @objc func pressButtonLogin() {
        let vc = SignInViewController()
        present(vc, animated: true)
    }
    
    @objc func pressButtonCreate() {
        let vc = SignUpViewController()
        present(vc, animated: true)
    }
    
    @objc func pressButtonAboutUs() {
        let vc = AboutUsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
