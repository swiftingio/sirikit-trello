//
//  AuthService.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 19/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import Foundation
import OAuthSwift
import UIKit

enum AuthError: Error {
    case AuthorizationError(Error)
}

protocol AuthServiceProtocol {
    func authenticate(viewController: UIViewController, completion: @escaping (AuthError?) -> Swift.Void)
    var oAuthToken: String? { get }
}

class AuthService: AuthServiceProtocol {
    static let sharedInstance = AuthService()
    
    let oauthSwift = OAuth1Swift(
        consumerKey:    "",
        consumerSecret: "",
        requestTokenUrl: "https://trello.com/1/OAuthGetRequestToken?scope=read,write,account&expiration=never&name=SiriKit-Trello",
        authorizeUrl: "https://trello.com/1/OAuthAuthorizeToken?scope=read,write,account&expiration=never&name=SiriKit-Trello",
        accessTokenUrl: "https://trello.com/1/OAuthGetAccessToken?scope=read,write,account&expiration=never&name=SiriKit-Trello"
    )
    
    private(set) var oAuthToken: String?
    private var oAuthTokenSecret: String?
    
    func authenticate(viewController: UIViewController, completion: @escaping (AuthError?) -> Swift.Void){
        
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthSwift)
        
        _ = oauthSwift.authorize (
            withCallbackURL: URL(string: "SiriKit-Trello://oauth-callback/trello")!,
            success: { [weak self] credential, response, parameters in
                self?.oAuthToken = credential.oauthToken
                self?.oAuthTokenSecret = credential.oauthTokenSecret
                completion(nil)
            },
            failure: { error in
                print(error.localizedDescription)
                print(error)
                completion(AuthError.AuthorizationError(error))
        }
        )
    }
}
