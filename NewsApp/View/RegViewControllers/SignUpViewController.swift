//
//  SignUpViewController.swift
//  NewsApp
//
//  Created by Алексей Орловский on 16.05.2023.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import SnapKit

class SignUpViewController: UIViewController {
    
    /// UI Elements
    let stripButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "stripGreen"), for: .normal)
        return button
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Create"
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let emailTextField: UITextField = {
        let emailField = UITextField()
        emailField.backgroundColor = .secondarySystemBackground
        emailField.layer.cornerRadius = 10
        emailField.font = .systemFont(ofSize: 18, weight: .black)
        emailField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        emailField.textColor = .secondaryLabel
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return emailField
    }()
    
    let passwordTextField: UITextField = {
        let passField = UITextField()
        passField.backgroundColor = .secondarySystemBackground
        passField.layer.cornerRadius = 10
        passField.font = .systemFont(ofSize: 18, weight: .black)
        passField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        passField.textColor = .secondaryLabel
        passField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return passField
    }()
    
    let repeatPasswordTextField: UITextField = {
        let repeatField = UITextField()
        repeatField.isSecureTextEntry = true
        repeatField.backgroundColor = .secondarySystemBackground
        repeatField.layer.cornerRadius = 10
        repeatField.font = .systemFont(ofSize: 18, weight: .black)
        repeatField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        repeatField.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        repeatField.attributedPlaceholder = NSAttributedString(
            string: "Repeat password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.tertiarySystemBackground])
        return repeatField
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(UIColor(red: 3/255, green: 187/255, blue: 97/255, alpha: 1), for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
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
        view.addSubview(signUpLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(enterButton)
        view.addSubview(stripButton)
        
        enterButton.addTarget(self, action: #selector(createUserAccount), for: .touchUpInside)
        stripButton.addTarget(self, action: #selector(stripEction), for: .touchUpInside)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stripButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(5)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(272)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(334)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(396)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(486)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
    }
}

/// @objc funcs
extension SignUpViewController {
    
    @objc func createUserAccount() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count > 6,
              let passwordRepeat = repeatPasswordTextField.text, !passwordRepeat.isEmpty else { showInvalidRegister(); return }
        
        createAccountAtFirebase(email: email, password: password)
        
        guard passwordTextField.text == repeatPasswordTextField.text else { showMatchPass(); return }
    }
    
    func createAccountAtFirebase(email: String, password: String) {
        Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else { return }
            
            guard error == nil else { strongSelf.showLoginIn(email: email, password: password); return }
            self?.dismiss(animated: true)
        })
    }
    
    @objc func stripEction() {
        dismiss(animated: true)
    }
}

/// Alerts
extension SignUpViewController {
    
    func showMinimumCharacters() {
        let alert = UIAlertController(title: "Password is too short!", message: "the minimum number of characters in the password is 6, the more complex your password, the more secure your account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func showInvalidRegister() {
        let alert = UIAlertController(title: "Not all fields are filled!", message: "Fill in the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showMatchPass() {
        let alert = UIAlertController(title: "Fields do not match", message: "The password and repeat password fields do not match. check if the characters are entered correctly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showLoginIn(email: String, password: String) {
        let alert = UIAlertController(title: "Create account",
                                      message: "Would you like to create an account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create",
                                      style: .default,
                                      handler: {_ in

            Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in

                guard self != nil else { return } /// guard let strongSelf = self else { return }
                guard error == nil else { print("Account creation failed"); return }
                
                let userId = result?.user.uid
                let email = email
                let data: [String: Any] = ["email": email]
                Firestore.firestore().collection("users").document(userId!).setData(data)
                
                print("You have signed in")
                self?.dismiss(animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: {_ in
        }))
        present(alert, animated: true)
    }
}


