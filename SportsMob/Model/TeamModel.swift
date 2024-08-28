//
//  TeamModel.swift
//  SportsMob
//
//  Created by sayed mansour on 28/08/2024.
//

import Foundation


struct TeamModelAPIResponse: Codable {
    let success: Int
    let result: [TeamModel]
}

struct TeamModel: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

struct Coach: Codable {
    let coachName: String
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}

struct Player: Codable {
    let playerKey: Int
    let playerImage: String?
    let playerName: String
    let playerNumber: String
    let playerType: String?
    
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
    }
}
//#
struct TeamsFromEventGenerator {
    static func getTeams(events: [EventModel]) -> [TeamModel] {
        var teams: [TeamModel] = []
        var teamsKey: Set<Int> = []
        for event in events {
            if !teamsKey.contains(event.homeTeamKey) {
                let team = TeamModel(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo, players: nil, coaches: nil)
                teams.append(team)
                teamsKey.insert(event.homeTeamKey)
            }
            if !teamsKey.contains(event.awayTeamKey) {
                let team = TeamModel(teamKey: event.awayTeamKey, teamName: event.eventAwayTeam ?? "", teamLogo: event.awayTeamLogo, players: nil, coaches: nil)
                teams.append(team)
                teamsKey.insert(event.awayTeamKey)
            }
        }
        return teams
    }
}
