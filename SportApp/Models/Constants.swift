//
//  Constants.swift
//  SportApp
//
//  Created by Omayma Marouf on 28/03/2021.
//

import Foundation

enum URLS : String {
    case sportsNameUrl = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    case legueNameUrl = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    case lequeDetailsUrl = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    case eventDetailsUrl = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    case teamDeatilsUrl = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    case TeamDetailsIDUrl = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
}
