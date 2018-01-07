//
//  BoardsConfigurator.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

protocol BoardsInteractorProtocol {
    func getBoards()
}

protocol BoardsViewControllerProtocol: class {
    func display(boards: [Board])
}

final class BoardsConfigurator: Configurator {
    
    func configure(_ viewController: BoardsViewController) {
        
        let router = BoardsRouter()
        router.viewController = viewController
        
        let interactor = BoardsInteractor()
        interactor.viewController = viewController
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
