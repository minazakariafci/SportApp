//
//  LequeIDModel.swift
//  SportApp
//
//  Created by mac on 3/27/21.
//

import Foundation
struct legueIDModel : Codable {
    let leagues : [LeaguesDetailsIDModel]?

    enum CodingKeys: String, CodingKey {

        case leagues = "leagues"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        leagues = try values.decodeIfPresent([LeaguesDetailsIDModel].self, forKey: .leagues)
    }

}
