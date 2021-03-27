//
//  EventModel.swift
//  SportApp
//
//  Created by mac on 3/27/21.
//

import Foundation
struct EventModel : Codable {
    let events : [Events]?

    enum CodingKeys: String, CodingKey {

        case events = "events"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        events = try values.decodeIfPresent([Events].self, forKey: .events)
    }

}
