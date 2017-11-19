//
//  LoginInteractor.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import Foundation
import OAuthSwift

final class LoginInteractor: LoginInteractorProtocol {
    weak var viewController: LoginViewControllerProtocol?
    
    private let authService: AuthServiceProtocol
    
    init(authService:AuthServiceProtocol = AuthService.sharedInstance){
        self.authService = authService
    }
    
    func signIn(){
        guard let vc = viewController as? UIViewController else{
            return
        }
        
        authService.authenticate(viewController: vc) { [weak self](error) in
            if nil == error {
                self?.viewController?.loggedIn()
            }
        }
    }
    
}
