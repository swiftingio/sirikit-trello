//
//  BoardsInteractor.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import Foundation


struct Board: Codable {
    var id: String
    var name: String
}

final class BoardsInteractor: BoardsInteractorProtocol {
    weak var viewController: BoardsViewControllerProtocol?
 
    private let authService: AuthServiceProtocol
    private let session: URLSession
    init(authService:AuthServiceProtocol = AuthService.sharedInstance, session: URLSession = URLSession.shared){
        self.authService = authService
        self.session = session
    }
    
    func getBoards() {
        guard let token = authService.oAuthToken else {
            return
        }
        let key = authService.consumerKey
        let urlString = "https://api.trello.com/1/members/me/boards?fields=name,id&key="+key+"&token="+token
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let responseData = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let boards = try decoder.decode([Board].self, from: responseData)
                DispatchQueue.main.async {
                    self?.viewController?.display(boards: boards)
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }
        dataTask.resume()
        
        /*
         https://api.trello.com/1/boards/560bf4298b3dda300c18d09c?fields=name,url&key={YOUR-API-KEY}&token={AN-OAUTH-TOKEN}
         
         GET /1/members/me/boards - Get an array of the Boards of a user
         GET /1/boards/[board_id]/cards - Get an array of Cards on a board
         GET /1/boards/[board_id]/lists - Get an array of Lists on a board
         */
        
    }
    
}
