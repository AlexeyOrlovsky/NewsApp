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
    let buttonLeave: UIButton = {
        let button = UIButton()
        button.setTitle("Leave", for: .normal)
        button.backgroundColor = UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.layer.cornerRadius = 25
        return button
    }()
    
    let buttonIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconAppNews"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    let buttonIconClose:  UIButton = {
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
    
    let buttonEditIcon: UIButton = {
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
    
    let buttonWebsite: UIButton = {
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
    
    let buttonSecurity: UIButton = {
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
    
    let buttonAboutUs: UIButton = {
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
    
    let buttonTime: UIButton = {
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
    
    let buttonShare: UIButton = {
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
    
    let buttonOdher: UIButton = {
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
        view.addSubview(buttonLeave)
        view.addSubview(buttonIcon)
        view.addSubview(nameLabel)
        view.addSubview(buttonEditIcon)
        view.addSubview(buttonWebsite)
        view.addSubview(buttonSecurity)
        view.addSubview(buttonTime)
        view.addSubview(buttonAboutUs)
        view.addSubview(buttonShare)
        view.addSubview(buttonOdher)
        
        buttonLeave.addTarget(self, action: #selector(targetButtonLeave), for: .touchUpInside)
        buttonIcon.addTarget(self, action: #selector(targetButtonIcon), for: .touchUpInside)
        
        buttonEditIcon.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        buttonWebsite.addTarget(self, action: #selector(targetButtonWebsite), for: .touchUpInside)
        buttonSecurity.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        buttonTime.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        buttonAboutUs.addTarget(self, action: #selector(targetButtonAboutUs), for: .touchUpInside)
        buttonShare.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
        buttonOdher.addTarget(self, action: #selector(targetButtonInDeveloping), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttonLeave.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonOdher.snp.bottom).offset(20)
            make.width.equalTo(165)
            make.height.equalTo(50)
        }
        
        buttonIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(190)
        }
        
        buttonEditIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(40)
        }
        
        buttonWebsite.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonEditIcon.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        buttonSecurity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonWebsite.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        buttonTime.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonSecurity.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        buttonAboutUs.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonTime.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        buttonShare.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonAboutUs.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        buttonOdher.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonShare.snp.bottom).offset(10)
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
        buttonIconClose.alpha = 0
        
        let blurEffect = UIBlurEffect(style: .prominent)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = view.bounds
        buttonIconClose.isHidden = false
        
        view.addSubview(visualEffectView!)
        view.addSubview(buttonIconClose)
        buttonIconClose.addTarget(self, action: #selector(targetButtonClose), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.5) {
            self.buttonIconClose.alpha = 1
        }
        
        buttonIconClose.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func targetButtonClose() {
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonIconClose.alpha = 0
        }) { (_) in
            self.buttonIconClose.isHidden = true
            self.buttonIconClose.alpha = 1
            self.buttonIcon.frame = self.view.bounds
            self.visualEffectView?.removeFromSuperview()
            self.visualEffectView = nil
            self.buttonIcon.addTarget(self, action: #selector(self.targetButtonIcon), for: .touchUpInside)
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
