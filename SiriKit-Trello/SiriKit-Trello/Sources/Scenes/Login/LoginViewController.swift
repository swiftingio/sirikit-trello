//
//  LoginViewController.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, Configurable {

    var interactor: LoginInteractorProtocol?
    var router: LoginRouter?
    
    private let usernameField: UITextField = UITextField()
    private let passwordField: UITextField = UITextField()
    private let logInButton: UIButton = UIButton()
    
    let label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        usernameField.placeholder = "username"
        passwordField.placeholder = "password"
        passwordField.isSecureTextEntry = true
        logInButton.setTitle("Sign In", for: .normal)
        logInButton.setTitleColor(UIColor.darkGray, for: .normal)
        logInButton.addTarget(self, action: #selector(logInPressed), for: UIControlEvents.touchUpInside)
        
        
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(logInButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            usernameField.widthAnchor.constraint(equalToConstant: 200),
            usernameField.heightAnchor.constraint(equalToConstant: 44.0),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            passwordField.widthAnchor.constraint(equalToConstant: 200),
            passwordField.heightAnchor.constraint(equalToConstant: 44.0),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            logInButton.widthAnchor.constraint(equalToConstant: 100),
            logInButton.heightAnchor.constraint(equalToConstant: 24.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func logInPressed() {
        guard let username = usernameField.text, let password = passwordField.text
            else { return }
        interactor?.signIn(username: username, password: password)
    }
}

extension LoginViewController: LoginViewControllerProtocol {

}
