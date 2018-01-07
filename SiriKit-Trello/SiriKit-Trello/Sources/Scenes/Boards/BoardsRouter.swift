//
//  BoardsRouter.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import UIKit

final class BoardsRouter {
    weak var viewController: BoardsViewController?
    
    func navigateToLists(board: Board){
        let vc = ListsViewController(configurator: ListsConfigurator())
        vc.interactor?.board = board
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
