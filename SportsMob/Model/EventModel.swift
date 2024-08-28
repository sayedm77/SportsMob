//
//  EventModel.swift
//  SportsMob
//
//  Created by sayed mansour on 26/08/2024.
//

import Foundation

struct EventModelApiResponse: Codable {
    let success: Int
    let result: [EventModel]
}

struct EventModel: Codable {
    let homeTeamLogo: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int
    let awayTeamLogo: String?
    let eventAwayTeam: String?
    let awayTeamKey: Int
    let leagueLogo: String?
    let eventFinalResult: String?
    let eventDate: String?
    let eventTime: String?

    enum CodingKeys: String, CodingKey {
        case homeTeamLogo = "home_team_logo"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case awayTeamLogo = "away_team_logo"
        case awayTeamKey = "away_team_key"
        case eventAwayTeam = "event_away_team"
        case leagueLogo = "league_logo"
        case eventFinalResult = "event_final_result"
        case eventDate = "event_date"
        case eventTime = "event_time"
    }
}
