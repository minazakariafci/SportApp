//
//  TeamDetailsModel.swift
//  SportApp
//
//  Created by mac on 3/28/21.
//

import Foundation
struct Teams : Codable {
    let idTeam : String?
    let idSoccerXML : String?
    let idAPIfootball : String?
    let intLoved : String?
    let strTeam : String?
    let strTeamShort : String?
    let strAlternate : String?
    let intFormedYear : String?
    let strSport : String?
    let strLeague : String?
    let idLeague : String?
    let strLeague2 : String?
    let idLeague2 : String?
    let strLeague3 : String?
    let idLeague3 : String?
    let strLeague4 : String?
    let idLeague4 : String?
    let strLeague5 : String?
    let idLeague5 : String?
    let strLeague6 : String?
    let idLeague6 : String?
    let strLeague7 : String?
    let idLeague7 : String?
    let strDivision : String?
    let strManager : String?
    let strStadium : String?
    let strKeywords : String?
    let strRSS : String?
    let strStadiumThumb : String?
    let strStadiumDescription : String?
    let strStadiumLocation : String?
    let intStadiumCapacity : String?
    let strWebsite : String?
    let strFacebook : String?
    let strTwitter : String?
    let strInstagram : String?
    let strDescriptionEN : String?
    let strDescriptionDE : String?
    let strDescriptionFR : String?
    let strDescriptionCN : String?
    let strDescriptionIT : String?
    let strDescriptionJP : String?
    let strDescriptionRU : String?
    let strDescriptionES : String?
    let strDescriptionPT : String?
    let strDescriptionSE : String?
    let strDescriptionNL : String?
    let strDescriptionHU : String?
    let strDescriptionNO : String?
    let strDescriptionIL : String?
    let strDescriptionPL : String?
    let strGender : String?
    let strCountry : String?
    let strTeamBadge : String?
    let strTeamJersey : String?
    let strTeamLogo : String?
    let strTeamFanart1 : String?
    let strTeamFanart2 : String?
    let strTeamFanart3 : String?
    let strTeamFanart4 : String?
    let strTeamBanner : String?
    let strYoutube : String?
    let strLocked : String?

    enum CodingKeys: String, CodingKey {

        case idTeam = "idTeam"
        case idSoccerXML = "idSoccerXML"
        case idAPIfootball = "idAPIfootball"
        case intLoved = "intLoved"
        case strTeam = "strTeam"
        case strTeamShort = "strTeamShort"
        case strAlternate = "strAlternate"
        case intFormedYear = "intFormedYear"
        case strSport = "strSport"
        case strLeague = "strLeague"
        case idLeague = "idLeague"
        case strLeague2 = "strLeague2"
        case idLeague2 = "idLeague2"
        case strLeague3 = "strLeague3"
        case idLeague3 = "idLeague3"
        case strLeague4 = "strLeague4"
        case idLeague4 = "idLeague4"
        case strLeague5 = "strLeague5"
        case idLeague5 = "idLeague5"
        case strLeague6 = "strLeague6"
        case idLeague6 = "idLeague6"
        case strLeague7 = "strLeague7"
        case idLeague7 = "idLeague7"
        case strDivision = "strDivision"
        case strManager = "strManager"
        case strStadium = "strStadium"
        case strKeywords = "strKeywords"
        case strRSS = "strRSS"
        case strStadiumThumb = "strStadiumThumb"
        case strStadiumDescription = "strStadiumDescription"
        case strStadiumLocation = "strStadiumLocation"
        case intStadiumCapacity = "intStadiumCapacity"
        case strWebsite = "strWebsite"
        case strFacebook = "strFacebook"
        case strTwitter = "strTwitter"
        case strInstagram = "strInstagram"
        case strDescriptionEN = "strDescriptionEN"
        case strDescriptionDE = "strDescriptionDE"
        case strDescriptionFR = "strDescriptionFR"
        case strDescriptionCN = "strDescriptionCN"
        case strDescriptionIT = "strDescriptionIT"
        case strDescriptionJP = "strDescriptionJP"
        case strDescriptionRU = "strDescriptionRU"
        case strDescriptionES = "strDescriptionES"
        case strDescriptionPT = "strDescriptionPT"
        case strDescriptionSE = "strDescriptionSE"
        case strDescriptionNL = "strDescriptionNL"
        case strDescriptionHU = "strDescriptionHU"
        case strDescriptionNO = "strDescriptionNO"
        case strDescriptionIL = "strDescriptionIL"
        case strDescriptionPL = "strDescriptionPL"
        case strGender = "strGender"
        case strCountry = "strCountry"
        case strTeamBadge = "strTeamBadge"
        case strTeamJersey = "strTeamJersey"
        case strTeamLogo = "strTeamLogo"
        case strTeamFanart1 = "strTeamFanart1"
        case strTeamFanart2 = "strTeamFanart2"
        case strTeamFanart3 = "strTeamFanart3"
        case strTeamFanart4 = "strTeamFanart4"
        case strTeamBanner = "strTeamBanner"
        case strYoutube = "strYoutube"
        case strLocked = "strLocked"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idTeam = try values.decodeIfPresent(String.self, forKey: .idTeam)
        idSoccerXML = try values.decodeIfPresent(String.self, forKey: .idSoccerXML)
        idAPIfootball = try values.decodeIfPresent(String.self, forKey: .idAPIfootball)
        intLoved = try values.decodeIfPresent(String.self, forKey: .intLoved)
        strTeam = try values.decodeIfPresent(String.self, forKey: .strTeam)
        strTeamShort = try values.decodeIfPresent(String.self, forKey: .strTeamShort)
        strAlternate = try values.decodeIfPresent(String.self, forKey: .strAlternate)
        intFormedYear = try values.decodeIfPresent(String.self, forKey: .intFormedYear)
        strSport = try values.decodeIfPresent(String.self, forKey: .strSport)
        strLeague = try values.decodeIfPresent(String.self, forKey: .strLeague)
        idLeague = try values.decodeIfPresent(String.self, forKey: .idLeague)
        strLeague2 = try values.decodeIfPresent(String.self, forKey: .strLeague2)
        idLeague2 = try values.decodeIfPresent(String.self, forKey: .idLeague2)
        strLeague3 = try values.decodeIfPresent(String.self, forKey: .strLeague3)
        idLeague3 = try values.decodeIfPresent(String.self, forKey: .idLeague3)
        strLeague4 = try values.decodeIfPresent(String.self, forKey: .strLeague4)
        idLeague4 = try values.decodeIfPresent(String.self, forKey: .idLeague4)
        strLeague5 = try values.decodeIfPresent(String.self, forKey: .strLeague5)
        idLeague5 = try values.decodeIfPresent(String.self, forKey: .idLeague5)
        strLeague6 = try values.decodeIfPresent(String.self, forKey: .strLeague6)
        idLeague6 = try values.decodeIfPresent(String.self, forKey: .idLeague6)
        strLeague7 = try values.decodeIfPresent(String.self, forKey: .strLeague7)
        idLeague7 = try values.decodeIfPresent(String.self, forKey: .idLeague7)
        strDivision = try values.decodeIfPresent(String.self, forKey: .strDivision)
        strManager = try values.decodeIfPresent(String.self, forKey: .strManager)
        strStadium = try values.decodeIfPresent(String.self, forKey: .strStadium)
        strKeywords = try values.decodeIfPresent(String.self, forKey: .strKeywords)
        strRSS = try values.decodeIfPresent(String.self, forKey: .strRSS)
        strStadiumThumb = try values.decodeIfPresent(String.self, forKey: .strStadiumThumb)
        strStadiumDescription = try values.decodeIfPresent(String.self, forKey: .strStadiumDescription)
        strStadiumLocation = try values.decodeIfPresent(String.self, forKey: .strStadiumLocation)
        intStadiumCapacity = try values.decodeIfPresent(String.self, forKey: .intStadiumCapacity)
        strWebsite = try values.decodeIfPresent(String.self, forKey: .strWebsite)
        strFacebook = try values.decodeIfPresent(String.self, forKey: .strFacebook)
        strTwitter = try values.decodeIfPresent(String.self, forKey: .strTwitter)
        strInstagram = try values.decodeIfPresent(String.self, forKey: .strInstagram)
        strDescriptionEN = try values.decodeIfPresent(String.self, forKey: .strDescriptionEN)
        strDescriptionDE = try values.decodeIfPresent(String.self, forKey: .strDescriptionDE)
        strDescriptionFR = try values.decodeIfPresent(String.self, forKey: .strDescriptionFR)
        strDescriptionCN = try values.decodeIfPresent(String.self, forKey: .strDescriptionCN)
        strDescriptionIT = try values.decodeIfPresent(String.self, forKey: .strDescriptionIT)
        strDescriptionJP = try values.decodeIfPresent(String.self, forKey: .strDescriptionJP)
        strDescriptionRU = try values.decodeIfPresent(String.self, forKey: .strDescriptionRU)
        strDescriptionES = try values.decodeIfPresent(String.self, forKey: .strDescriptionES)
        strDescriptionPT = try values.decodeIfPresent(String.self, forKey: .strDescriptionPT)
        strDescriptionSE = try values.decodeIfPresent(String.self, forKey: .strDescriptionSE)
        strDescriptionNL = try values.decodeIfPresent(String.self, forKey: .strDescriptionNL)
        strDescriptionHU = try values.decodeIfPresent(String.self, forKey: .strDescriptionHU)
        strDescriptionNO = try values.decodeIfPresent(String.self, forKey: .strDescriptionNO)
        strDescriptionIL = try values.decodeIfPresent(String.self, forKey: .strDescriptionIL)
        strDescriptionPL = try values.decodeIfPresent(String.self, forKey: .strDescriptionPL)
        strGender = try values.decodeIfPresent(String.self, forKey: .strGender)
        strCountry = try values.decodeIfPresent(String.self, forKey: .strCountry)
        strTeamBadge = try values.decodeIfPresent(String.self, forKey: .strTeamBadge)
        strTeamJersey = try values.decodeIfPresent(String.self, forKey: .strTeamJersey)
        strTeamLogo = try values.decodeIfPresent(String.self, forKey: .strTeamLogo)
        strTeamFanart1 = try values.decodeIfPresent(String.self, forKey: .strTeamFanart1)
        strTeamFanart2 = try values.decodeIfPresent(String.self, forKey: .strTeamFanart2)
        strTeamFanart3 = try values.decodeIfPresent(String.self, forKey: .strTeamFanart3)
        strTeamFanart4 = try values.decodeIfPresent(String.self, forKey: .strTeamFanart4)
        strTeamBanner = try values.decodeIfPresent(String.self, forKey: .strTeamBanner)
        strYoutube = try values.decodeIfPresent(String.self, forKey: .strYoutube)
        strLocked = try values.decodeIfPresent(String.self, forKey: .strLocked)
    }

}
