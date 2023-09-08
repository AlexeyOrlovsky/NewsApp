//
//  SignInViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import SnapKit
import RealmSwift

class SignInViewController: UIViewController {
    
    /// UI Elements
    let stripButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "stripGreen"), for: .normal)
        return button
    }()
    
    let singInLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let emailTextField: UITextField = {
        let emailField = UITextField()
        emailField.backgroundColor = .secondarySystemBackground
        emailField.layer.cornerRadius = 10
        emailField.font = .boldSystemFont(ofSize: 18)
        emailField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        emailField.textColor = .secondaryLabel
        emailField.font = .systemFont(ofSize: 18, weight: .black)
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return emailField
    }()
    
    let passwordTextField: UITextField = {
        let passField = UITextField()
        passField.isSecureTextEntry = true
        passField.backgroundColor = .secondarySystemBackground
        passField.layer.cornerRadius = 10
        passField.font = .boldSystemFont(ofSize: 18)
        passField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passField.textColor = .secondaryLabel
        passField.font = .systemFont(ofSize: 18, weight: .black)
        passField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return passField
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1), for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
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
        view.addSubview(singInLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
        view.addSubview(stripButton)
        
        enterButton.addTarget(self, action: #selector(accountLogin), for: .touchUpInside)
        stripButton.addTarget(self, action: #selector(stripEction), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stripButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(5)
        }
        
        singInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(272)
            make.width.equalTo(340)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(334)
            make.width.equalTo(340)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(420)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
    }
}

/// @objc funcs
extension SignInViewController {

    /// Login user
    @objc private func accountLogin() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else { showEmptyFields(); return }
        
        existenceUser(email: email, password: password)
    }
    
    func existenceUser(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [self] authResults, error in
            guard let result = authResults, error == nil else { showInvalidLogin(); return }
            _ = result.user
            
            saveUserInRealm(email: email, password: password)
        }
    }
    
    func saveUserInRealm(email: String, password: String) {
        let user = User()
        user.email = email
        user.password = password
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
            NavigationManager.shared.showAuthorizedUserStage()
        }
    }
    
    @objc func stripEction() {
        dismiss(animated: true)
    }
}

/// Alerts
extension SignInViewController {
    func showEmptyFields() {
        let alert = UIAlertController(title: "Empty!", message: "Fill in all the fields. Email and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
        
    }
    
    func showInvalidLogin() {
        let alert = UIAlertController(title: "This account does not exist!", message: "This account does not exist, check the data or create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}



