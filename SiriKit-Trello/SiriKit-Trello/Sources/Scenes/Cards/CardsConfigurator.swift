//
//  CardsConfigurator.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

protocol CardsInteractorProtocol {
    func getCards()
    var list: List? { get set }
}

protocol CardsViewControllerProtocol: class {
    func display(cards: [Card])
    var title: String? { get set }
}

final class CardsConfigurator: Configurator {
    
    func configure(_ viewController: CardsViewController) {
        
        let router = CardsRouter()
        router.viewController = viewController
        
        let interactor = CardsInteractor()
        interactor.viewController = viewController
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
