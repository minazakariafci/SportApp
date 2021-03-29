//
//  TeamModel.swift
//  SportApp
//
//  Created by mac on 3/28/21.
//

import Foundation
struct TeamModel : Codable {
    let teams : [Teams]?

    enum CodingKeys: String, CodingKey {

        case teams = "teams"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teams = try values.decodeIfPresent([Teams].self, forKey: .teams)
    }

}
