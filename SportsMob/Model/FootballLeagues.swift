//
//  FootballLeagues.swift
//  SportsMob
//
//  Created by sayed mansour on 25/08/2024.
//

import Foundation
struct FootballLeaguesBaseResponse : Codable {
    let success : Int?
    let result : [Leagues]

}

struct Leagues: Codable {
    let league_key: Int
    let league_name: String
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
    let league_year: String?
}
