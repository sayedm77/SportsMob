//
//  TeamDetailsViewModel.swift
//  SportsMob
//
//  Created by sayed mansour on 28/08/2024.
//

import Foundation
class TeamDetailsViewModel {
    var manager : NetworkManager!
    var sport : SportType?
    var teamID : Int?
    var team : [TeamModel] = [] {
        didSet{
            self.players = team[0].players ?? []
            bindResultToViewController()
        }
    }
    var players : [Player] = []
    var bindResultToViewController : (()->()) = {}
    var noResultFound : (()->()) = {}
    
    init() {
        manager = NetworkManager.manager
    }
    
    func getTeamDetails() {
        guard let sport = sport else {return}
        guard let teamID = teamID else {return}
        guard let url = url.UrlTeamsDetails(sport: sport, TeamID: teamID)else {return}
        manager.fetchData(url: url, model: TeamModelAPIResponse.self) { result, error in
            if error != nil {
                self.noResultFound()
            }
            if let result = result {
                self.team = result.result
                if self.team[0].players == nil || self.team[0].players!.isEmpty {
                    self.noResultFound()
                }
            } else {
                print(error!)
                self.noResultFound()
            }
        }
    }
    
    
    func getPlayersCount() -> Int {
        return players.count
    }
    
    func getPlayer(index: Int) -> Player {
        return players[index]
    }
    
    func getSportType() -> SportType {
        return sport ?? .football
    }
    
    
    
    
}
