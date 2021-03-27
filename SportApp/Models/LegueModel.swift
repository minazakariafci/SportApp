//
//  LegueModel.swift
//  SportApp
//
//  Created by mac on 3/26/21.
//

import Foundation
struct LegueModel : Codable {
    let leagues : [LegueDetailsModel]?

    enum CodingKeys: String, CodingKey {

        case leagues = "leagues"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        leagues = try values.decodeIfPresent([LegueDetailsModel].self, forKey: .leagues)
    }

}
