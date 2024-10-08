//
//  LeagueDetailsViewModel.swift
//  SportsMob
//
//  Created by sayed mansour on 26/08/2024.
//

import Foundation
import CoreData
class LeagueDetailsViewModel{
    
    var sport : SportType?
    var idLeague : Int?
    var league : Leagues!
    var upcomingEvents: [EventModel] = []
    var latestEvents: [EventModel] = []
    var teams: [TeamModel] = []
    var bindResultToVC: (()->()) = {}
    var notFoundData: (()->()) = {}
    var noData: (()->()) = {}
    let manager = NetworkManager.manager
    let coreDataService: CoreDataServiceProtocol!
    var doneRequests = [0, 0] {
        didSet {
            bindResultToVC()
        }
    }
    
    
    init() {
        coreDataService = CoreDataService.shared
        sport = .football
        league = Leagues(league_key: 332, league_name: "MLS", country_key: nil, country_name: nil, league_logo: nil, country_logo: nil, league_year: nil)
    }
    
    
    func getDetails(){
        
        getUpcomingEvents()
        getLatestResults()
    }
    
    func getUpcomingEvents() {
        let upcomingURL = url.getLeagueDetailsURL(sport: sport! , leagueID: league.league_key, forDate: .nextYear)
        manager.fetchData(url: upcomingURL, model: EventModelApiResponse.self) { [weak self] response, error in
            if let error = error {
                print(error.localizedDescription)
                self?.doneRequests[0] = 1
                return
            }
            guard let response = response else {
                print("No data in response")
                self?.doneRequests[0] = 1
                return
            }
            self?.upcomingEvents = response.result.reversed()
            self?.doneRequests[0] = 1
        }
    }
    
//    func getEvents()  {
//        manager.fetchData(url: url.getLeagueDetailsURL(sport: sport ?? .football, leagueID: league.league_key, forDate: .nextYear), model: EventModelApiResponse.self, completion: { response, error in
//            if let response = response {
//                self.upcomingEvents = response.result
//                DispatchQueue.main.async {
//                    self.bindResultToVC()
//                }
//            } else {
//                // display photo if no data come from all section
//               self.notFoundData()
//            }
//        })
//        
//    }
    func getLatestResults()  {
        manager.fetchData(url: url.getLeagueDetailsURL(sport: sport ?? .football, leagueID: league.league_key, forDate: .prevYear), model: EventModelApiResponse.self, completion: { response, error in
            if let response = response {
                self.latestEvents = response.result
                self.getTeams()
                DispatchQueue.main.async {
                    self.bindResultToVC()
                }
            } else {
                self.notFoundData()

            }
        })
        
    }
    func getTeams() {
        teams = url.getTeams(latestEvents: latestEvents)
        self.bindResultToVC()
    }
    func addToFavorites() {
        coreDataService.addLeague(league: league, sport: sport!)
    }
    
    func removeFromFavorites() {
        coreDataService.deleteLeague(leagueKey: league.league_key, sport: sport!)
    }
    
    func checkFavorite() -> Bool {
        return coreDataService.checkFav(leagueKey: league.league_key, sport: sport!)
    }
    
}
