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
    
    
}
