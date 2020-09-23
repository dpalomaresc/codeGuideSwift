//
//  ModelExample.swift
//  CodeGuideSwiftXcode
//
//  Created by Diego Palomares Castro on 23/09/20.
//  Copyright © 2020 CITI Value in Real Time. All rights reserved.
//

import Foundation

struct AddCardResponse: Decodable {

    var httpCode: Int?
    var token: String?
    var isDefault: Bool = false
    var iin: Int
    var lastDigits: String?
    var mark: String?

    enum CodingKeys: String, CodingKey {
        case status
        case httpCode = "http_code"
        case data
        case card = "tarjeta"
        case token
        case isDefault = "default"
        case iin
        case marca
        case terminacion
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.httpCode = try? container.decode(Int.self, forKey: .httpCode)
        //nested es para no hacer todo el modelo si es que solo quieres esa variable
        let dataContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let cardContainer = try? dataContainer?.nestedContainer(keyedBy: CodingKeys.self, forKey: .card)
        self.lastDigits = try? cardContainer?.decode(String.self, forKey: .terminacion)
        self.mark = try? cardContainer?.decode(String.self, forKey: .marca)
        self.token = try? cardContainer?.decode(String.self, forKey: .token)
        self.isDefault = (try? cardContainer?.decode(Bool.self, forKey: .isDefault)) ?? false
        self.iin = (try? cardContainer?.decode(Int.self, forKey: .iin)) ?? 0
    }
}
