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
    static let token = "0bc68f46726057023e1e02eb28928e583985eb955391773f06338d53ea5c234b"
    
 
    
    static func UrlLeagues (sport : SportType) -> URL? {
        return URL(string: baseURL + sport.rawValue + leagues + apiKey)
    }
    static func getLeagueDetailsURL(sport: SportType, leagueID: Int, forDate range: DateRange) -> URL? {
        return URL(string: baseURL + sport.rawValue + leagueDetails + "\(leagueID)" + range.query + apiKey)
    }
    
    static func getTeamDetailsURL(sport: SportType, teamID: Int) -> URL? {
        return URL(string: baseURL + sport.rawValue + teamDetails + "\(teamID)" + apiKey)
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
