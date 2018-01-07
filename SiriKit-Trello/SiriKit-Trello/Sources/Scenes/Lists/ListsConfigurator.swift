//
//  ListsConfigurator.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

protocol ListsInteractorProtocol {
    func getLists()
    var board: Board? { get set }
}

protocol ListsViewControllerProtocol: class {
    func display(lists: [List])
    func update(title: String)
    var title: String? { get set }
}

final class ListsConfigurator: Configurator {
    
    func configure(_ viewController: ListsViewController) {
        
        let router = ListsRouter()
        router.viewController = viewController
        
        let interactor = ListsInteractor()
        interactor.viewController = viewController
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
