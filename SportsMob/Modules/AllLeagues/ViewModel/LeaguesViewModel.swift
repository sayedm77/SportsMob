//
//  LeaguesViewModel.swift
//  SportsMob
//
//  Created by sayed mansour on 23/08/2024.
//

import Foundation
import CoreData
import UIKit


class LeaguesViewModel{
    var checkFav: Bool = true
    var leagues: [Leagues] = []
    var onLeaguesFetched: (() -> Void)?
    var onFetchFailed: ((Error) -> Void)?
    let manager = NetworkManager.manager
    private let context = (UIApplication.shared.delegate as! AppDelegate).context
    var sport: SportType?
    
    
    func getLeagues() {
        if checkFav {
            let favoriteLeagues = fetchFavoriteLeagues()
            if let firstFavoriteLeague = favoriteLeagues.first {
                if let sportType = SportType(from: firstFavoriteLeague.sport ?? "") {
                    self.sport = sportType
                } else {
                    print("Invalid SportType string")
                }
            }
            leagues = favoriteLeagues.map { favoriteLeague in
                Leagues(
                    league_key: Int(favoriteLeague.leagueKey),
                    league_name: favoriteLeague.leagueName ?? "",
                    country_key: nil,
                    country_name: nil,
                    league_logo: nil,
                    country_logo: favoriteLeague.leagueLogo,
                    league_year: nil
                )
            }
            onLeaguesFetched?()
        } else {
            guard let sport = sport else {
                print("Sport is nil. Cannot fetch leagues.")
                return
            }
            manager.fetchData(url: url.UrlLeagues(sport: sport), model: FootballLeaguesBaseResponse.self) { response, error in
                if let response = response {
                    self.leagues = response.result
                    self.onLeaguesFetched?()
                    
                } else if let error = error {
                    self.onFetchFailed?(error)
                    print("errror")
                }
                
            }
        }
    }
    
        func numberOfLeagues() -> Int {
            if checkFav {
                return fetchFavoriteLeagues().count
            } else {
                return leagues.count
            }
            
        }
    
    func getLeague(index: Int) -> Leagues {
        return leagues[index]
    }
    private  func fetchFavoriteLeagues() -> [FavouriteLeagues] {
            let fetchRequest: NSFetchRequest<FavouriteLeagues> = FavouriteLeagues.fetchRequest()
            
            do {
                return try context.fetch(fetchRequest)
            } catch {
                print("Failed to fetch favorite leagues: \(error)")
                return []
            }
        }
    func getYouTubeChannelURL(for index: Int) -> URL? {
        let leagueName = leagues[index].league_name.replacingOccurrences(of: " ", with: "")
        let youtubeUrlString = "https://www.youtube.com/@\(leagueName)"
        return URL(string: youtubeUrlString)
    
    }

        
    
}
