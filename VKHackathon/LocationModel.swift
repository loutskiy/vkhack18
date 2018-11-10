//
//  LocationModel.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationModel: Mappable {
    var id: Int?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var bank_name: String?
    var type: Int?
    var work_time: String?
    var currency: String?
    var cashless: Bool?
    var IsMerchant: Bool?
    var address: String?
    var bank_id: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        bank_name <- map["bank_name"]
        type <- map["type"]
        work_time <- map["work_time"]
        currency <- map["currency"]
        cashless <- map["cashless"]
        IsMerchant <- map["IsMerchant"]
        address <- map["address"]
        bank_id <- map["bank_id"]
    }
}
