//
//  CardsInteractor.swift
//  SiriKit-Trello
//
//  Created by Michal Wojtysiak on 05/11/2017.
//  Copyright © 2017 Michal Wojtysiak. All rights reserved.
//

import Foundation

struct Card: Codable {
    var id: String
    var name: String
    var desc: String?
}

final class CardsInteractor: CardsInteractorProtocol {
    weak var viewController: CardsViewControllerProtocol?
    
    var list: List? {
        didSet {
            viewController?.title = list?.name
        }
    }
 
    private let authService: AuthServiceProtocol
    private let session: URLSession
    init(authService:AuthServiceProtocol = AuthService.sharedInstance, session: URLSession = URLSession.shared){
        self.authService = authService
        self.session = session
    }
    
    func getCards() {
        guard let token = authService.oAuthToken,
        let list = list else {
            return
        }
        let key = authService.consumerKey
        let urlString = "https://api.trello.com/1/lists/"+list.id+"/cards?key="+key+"&token="+token
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
                let Cards = try decoder.decode([Card].self, from: responseData)
                DispatchQueue.main.async {
                    self?.viewController?.display(cards: Cards)
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }
        dataTask.resume()
        
        /*
         https://api.trello.com/1/Cards/560bf4298b3dda300c18d09c?fields=name,url&key={YOUR-API-KEY}&token={AN-OAUTH-TOKEN}
         
         GET /1/members/me/Cards - Get an array of the Cards of a user
         GET /1/Cards/[board_id]/cards - Get an array of Cards on a board
         GET /1/Cards/[board_id]/Cards - Get an array of Cards on a board
         */
        
    }
    
}
