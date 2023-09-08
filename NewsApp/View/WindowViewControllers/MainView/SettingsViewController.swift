//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import SafariServices
import SwiftUI
import SnapKit
import UIKit
import RealmSwift

class SettingsViewController: UIViewController {
    
    var visualEffectView: UIVisualEffectView?
    let topHeadlinesURL = URL(string: "https://pranx.com/hacker/typer/")
    
    /// UI Elements
    let leaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Leave", for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.layer.cornerRadius = 25
        return button
    }()
    
    let iconButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconAppNews"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    let iconCloseButton:  UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconAppNews"), for: .normal)
        button.adjustsImageWhenHighlighted = false // убирает затемнение кнопки
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " Whea</>"
        label.font = .systemFont(ofSize: 24, weight: .black)
        return label
    }()
    
    let editIconButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.viewfinder"), for: .normal)
        button.setTitle("  Change photo", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let websiteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "network"), for: .normal)
        button.setTitle("  Website", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.contentHorizontalAlignment = .left
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let securityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.shield.fill"), for: .normal)
        button.setTitle("  Security", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.contentHorizontalAlignment = .left
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let aboutUsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.bubble.fill"), for: .normal)
        button.setTitle("  About the application", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.contentHorizontalAlignment = .left
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let timeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "timer"), for: .normal)
        button.setTitle("  Your time in the app", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.contentHorizontalAlignment = .left
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        button.setTitle("  Share", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.contentHorizontalAlignment = .left
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        return button
    }()
    
    let odherButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "note"), for: .normal)
        button.setTitle("  Other", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
        button.contentHorizontalAlignment = .left
        button.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        button.tintColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
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
        view.addSubview(leaveButton)
        view.addSubview(iconButton)
        view.addSubview(nameLabel)
        view.addSubview(editIconButton)
        view.addSubview(websiteButton)
        view.addSubview(securityButton)
        view.addSubview(timeButton)
        view.addSubview(aboutUsButton)
        view.addSubview(shareButton)
        view.addSubview(odherButton)
        
        leaveButton.addTarget(self, action: #selector(targetButtonLeave), for: .touchUpInside)
        iconButton.addTarget(self, action: #selector(targetButtonIcon), for: .touchUpInside)
        
        editIconButton.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        websiteButton.addTarget(self, action: #selector(targetButtonWebsite), for: .touchUpInside)
        securityButton.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        timeButton.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        aboutUsButton.addTarget(self, action: #selector(targetButtonAboutUs), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        odherButton.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        leaveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(odherButton.snp.bottom).offset(20)
            make.width.equalTo(165)
            make.height.equalTo(50)
        }
        
        iconButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(190)
        }
        
        editIconButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(40)
        }
        
        websiteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(editIconButton.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        securityButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(websiteButton.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        timeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(securityButton.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        aboutUsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeButton.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(aboutUsButton.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        odherButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shareButton.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
    }
}

/// @objc funcs
extension SettingsViewController {
    
    @objc func targetButtonAboutUs() {
        let vc = AboutUsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func targetButtonIcon() {
        iconCloseButton.alpha = 0
        
        let blurEffect = UIBlurEffect(style: .prominent)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = view.bounds
        iconCloseButton.isHidden = false
        
        view.addSubview(visualEffectView!)
        view.addSubview(iconCloseButton)
        iconCloseButton.addTarget(self, action: #selector(targetButtonClose), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.5) {
            self.iconCloseButton.alpha = 1
        }
        
        iconCloseButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func targetButtonClose() {
        UIView.animate(withDuration: 0.5, animations: {
            self.iconCloseButton.alpha = 0
        }) { (_) in
            self.iconCloseButton.isHidden = true
            self.iconCloseButton.alpha = 1
            self.iconButton.frame = self.view.bounds
            self.visualEffectView?.removeFromSuperview()
            self.visualEffectView = nil
            self.iconButton.addTarget(self, action: #selector(self.targetButtonIcon), for: .touchUpInside)
        }
    }
    
    @objc func targetButtonLeave() {
        showAlertLeave()
    }
    
    @objc func targetButtonInDeveloping() {
        showAlerInDeveloping()
    }
    
    @objc func targetButtonWebsite() {
        guard let url = topHeadlinesURL else { return }

        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}

/// Alerts
extension SettingsViewController {
    func showAlerInDeveloping() {
        let alert = UIAlertController(title: "In developing", message: "Wait a bit", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default))
        present(alert, animated: true)
    }
    
    func showAlertLeave() {
        let alert = UIAlertController(title: "Are you sure you want to log out of your account?", message: "If yes click the button below", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) {_ in
               let realm = try! Realm()

               if let user = realm.objects(User.self).first {
                   try! realm.write {
                       realm.delete(user)
                   }
               }
            
               NavigationManager.shared.showNotAuthorizedUserStage()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
    }
}
