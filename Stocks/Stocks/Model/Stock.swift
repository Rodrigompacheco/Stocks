//
//  Stock.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import Foundation

class Stock: Codable {
    let code: String
    let name: String
    let percentStatus: Float
    let currentValue: Float
    
    enum CodingKeys: String, CodingKey {
        case code = "symbol"
        case name = "displayName"
        case percentStatus = "regularMarketChange"
        case currentValue = "postMarketPrice"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(String.self, forKey: .code)
        name = try values.decode(String.self, forKey: .name)
        percentStatus = try values.decode(Float.self, forKey: .percentStatus)
        currentValue = try values.decode(Float.self, forKey: .currentValue)
    }
      
    init(code: String, name: String, percentStatus: Float, currentValue: Float) {
        self.code = code
        self.name = name
        self.percentStatus = percentStatus
        self.currentValue = currentValue
    }
}
