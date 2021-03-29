//
//  TeamIDModel.swift
//  SportApp
//
//  Created by mac on 3/29/21.
//

import Foundation
struct TeamIDModel : Codable {
    let teams : [TeamsDetails]?

    enum CodingKeys: String, CodingKey {

        case teams = "teams"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teams = try values.decodeIfPresent([TeamsDetails].self, forKey: .teams)
    }

}
