//
//  LoginViewController.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import UIKit
import OAuthSwift

final class LoginViewController: UIViewController, Configurable {

    var interactor: LoginInteractorProtocol?
    var router: LoginRouter?
    
    private let logInButton: UIButton = UIButton()
    private let label: UILabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.text = "Login with"
        label.textAlignment = .center
        logInButton.setImage(#imageLiteral(resourceName: "Trello"), for: .normal)
        logInButton.imageView?.contentMode = .scaleAspectFit
        logInButton.setTitleColor(UIColor.darkGray, for: .normal)
        logInButton.addTarget(self, action: #selector(logInPressed), for: UIControlEvents.touchUpInside)
        
        
        view.addSubview(label)
        view.addSubview(logInButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 44.0),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            logInButton.widthAnchor.constraint(equalToConstant: 200),
            logInButton.heightAnchor.constraint(equalToConstant: 44.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func logInPressed() {
        interactor?.signIn()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func loggedIn() {
        router?.navigateToBoards()
    }
}
