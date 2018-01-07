//
//  ListsRouter.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import Foundation

final class ListsRouter {
     weak var viewController: ListsViewController?
    
    func navigateToCards(list: List){
        let vc = CardsViewController(configurator: CardsConfigurator())
        vc.interactor?.list = list
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
