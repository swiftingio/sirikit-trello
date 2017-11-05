//
//  LoginConfigurator.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

protocol LoginInteractorProtocol {
    func signIn(username: String, password: String)
}

protocol LoginViewControllerProtocol: class {
    //func displaySignInError(message: String)
}

final class LoginConfigurator: Configurator {
    
    func configure(_ viewController: LoginViewController) {
        
        let router = LoginRouter()
        router.viewController = viewController
        
        let interactor = LoginInteractor()
        interactor.viewController = viewController
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
