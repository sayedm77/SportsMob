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

