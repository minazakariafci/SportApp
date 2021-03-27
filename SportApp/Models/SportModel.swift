//
//  SportModel.swift
//  SportApp
//
//  Created by mac on 3/26/21.
//

import Foundation

struct SportModel : Codable {
    let sports : [SportDetailsModel]?

    enum CodingKeys: String, CodingKey {

        case sports = "sports"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sports = try values.decodeIfPresent([SportDetailsModel].self, forKey: .sports)
    }

}
