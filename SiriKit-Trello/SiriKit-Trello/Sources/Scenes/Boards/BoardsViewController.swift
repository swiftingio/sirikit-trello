//
//  BoardsViewController.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import UIKit

final class BoardsViewController: UIViewController, Configurable {

    var interactor: BoardsInteractorProtocol?
    var router: BoardsRouter?
    private let tableView = UITableView()
    private let cellIdentifier = "UITableViewCell"
    private var boards: [Board] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Boards"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        setupConstraints()
        interactor?.getBoards()
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension BoardsViewController: BoardsViewControllerProtocol {
    func display(boards: [Board]) {
        self.boards = boards
        tableView.reloadData()
    }

}

extension BoardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToLists(board: boards[indexPath.row])
    }
}

extension BoardsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = boards[indexPath.row].name
        return cell
    }
}
