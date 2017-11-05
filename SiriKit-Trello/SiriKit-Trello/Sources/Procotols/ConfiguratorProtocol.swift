//
//  ConfiguratorProtocol.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import UIKit

protocol Configurator {
    associatedtype Controller: UIViewController
    func configure(_ viewController: Controller)
}

protocol Configurable {
    init<T: Configurator>(configurator: T) where T.Controller == Self
}

extension Configurable where Self: UIViewController {
    init<T: Configurator>(configurator: T) where T.Controller == Self {
        self.init()
        configurator.configure(self)
    }
}
