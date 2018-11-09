//
//  BinModel.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class BinModel: Mappable {
    var scheme: String?
    var type: String?
    var brand: String?
    var country: BinCountryModel?
    var bank: BinBankModel?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        scheme <- map["scheme"]
        type <- map["type"]
        brand <- map["brand"]
        country <- map["country"]
        bank <- map["bank"]
    }
}

class BinBankModel: Mappable {
    var numeric: Int?
    var alpha2: String?
    var name: String?
    var emoji: String?
    var currency: String?
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        numeric <- map["numeric"]
        alpha2 <- map["alpha2"]
        name <- map["name"]
        emoji <- map["emoji"]
        currency <- map["currency"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}

class BinCountryModel: Mappable {
    var name: String?
    var url: String?
    var phone: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
        phone <- map["phone"]
    }
}
