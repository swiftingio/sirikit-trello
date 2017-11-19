//
//  LoginRouter.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import UIKit

final class LoginRouter {
    weak var viewController: LoginViewController?
    func navigateToBoards(){
        let boardsVC = BoardsViewController(configurator: BoardsConfigurator())
        let nav = UINavigationController(rootViewController: boardsVC)
        viewController?.present(nav, animated: true, completion: nil)
    }
}
