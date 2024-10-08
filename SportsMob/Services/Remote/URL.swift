//
//  URL.swift
//  SportsMob
//
//  Created by sayed mansour on 24/08/2024.
//

import Foundation
struct url {
    static let baseURL = "https://apiv2.allsportsapi.com"
    static let leagues = "/?met=Leagues"
    static let leagueDetails = "/?met=Fixtures&leagueId="
    static let teamDetails = "/?&met=Teams&teamId="
    static let apiKey = "&APIkey=" + token
    static let token = "d3bea2f37d46b6b7aa6c504992d7c9efbdef6944e8c333889ecef4165b8d0f5c"
    
    static func UrlLeagues (sport : SportType) -> URL? {
        return URL(string: baseURL + sport.rawValue + leagues + apiKey)
    }
    static func getLeagueDetailsURL(sport: SportType, leagueID: Int, forDate range: DateRange) -> URL? {
        return URL(string: baseURL + sport.rawValue + leagueDetails + "\(leagueID)" + range.query + apiKey)
    }
    
    
    static func UrlTeamsDetails (sport: SportType, TeamID: Int) -> URL? {
        print("HELLO")
        return URL(string: baseURL + sport.rawValue + teamDetails + "\(TeamID)" + apiKey)
    }
    
    
    
    static func getTeams(latestEvents: [EventModel]) -> [TeamModel] {
        var arrofTeams : [TeamModel] = []
        var IdSet : Set<Int> = []
        for event in latestEvents {
            if !IdSet.contains(event.homeTeamKey){
                let team = TeamModel(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo, players: nil, coaches: nil)
                arrofTeams.append(team)
                IdSet.insert(event.homeTeamKey)
            }
            if !IdSet.contains(event.homeTeamKey){
                let team = TeamModel(teamKey: event.awayTeamKey, teamName: event.eventAwayTeam ?? "", teamLogo: event.awayTeamLogo, players: nil, coaches: nil)
                arrofTeams.append(team)
                IdSet.insert(event.awayTeamKey)
            }
        }
        
        return arrofTeams
    }

}
//#
enum DateRange: String {
    case prevYear
    case nextYear
    
    var query: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        
        switch self {
        case .prevYear:
            let pastYear = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
            //            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: currentDate))"

            let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: prevDay))"
        case .nextYear:
            let comingYear = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
            //            return "&from=\(formatter.string(from: currentDate))&to=\(formatter.string(from: comingYear))"
            let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            return "&from=\(formatter.string(from: nextDay))&to=\(formatter.string(from: comingYear))"
        }
    }
}
