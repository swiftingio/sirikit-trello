//
//  ListsInteractor.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import Foundation

struct List: Codable {
    var id: String
    var name: String
}

final class ListsInteractor: ListsInteractorProtocol {
    weak var viewController: ListsViewControllerProtocol?
    
    var board: Board? {
        didSet {
            viewController?.title = board?.name
        }
    }
 
    private let authService: AuthServiceProtocol
    private let session: URLSession
    init(authService:AuthServiceProtocol = AuthService.sharedInstance, session: URLSession = URLSession.shared){
        self.authService = authService
        self.session = session
    }
    
    func getLists() {
        guard let token = authService.oAuthToken,
        let board = board else {
            return
        }
        let key = authService.consumerKey
        let urlString = "https://api.trello.com/1/boards/"+board.id+"/lists?key="+key+"&token="+token
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let responseData = data else { return }
            print(NSString(data: responseData, encoding: String.Encoding.utf8.rawValue))
            
            let decoder = JSONDecoder()
            do {
                let lists = try decoder.decode([List].self, from: responseData)
                DispatchQueue.main.async {
                    self?.viewController?.display(lists: lists)
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }
        dataTask.resume()
        
        /*
         https://api.trello.com/1/Lists/560bf4298b3dda300c18d09c?fields=name,url&key={YOUR-API-KEY}&token={AN-OAUTH-TOKEN}
         
         GET /1/members/me/Lists - Get an array of the Lists of a user
         GET /1/Lists/[board_id]/cards - Get an array of Cards on a board
         GET /1/Lists/[board_id]/lists - Get an array of Lists on a board
         */
        
    }
    
}
