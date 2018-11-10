//
//  ServerManager.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ServerManager {
    static let shared = ServerManager()
    
    static func getBinFromCardNumber(_ number: String, success: @escaping(_ binModel: BinModel) -> Void) {
        Alamofire.request(URL(string: "https://lookup.binlist.net/\(number)")!).responseJSON { (response) in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String:AnyObject] {
                    let data = Mapper<BinModel>().map(JSONObject: JSON)!
                    success(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getAllLocations(success: @escaping(_ locations: [LocationModel]) -> Void) {
        Alamofire.request(URL(string:"https://ss.bigbadbird.ru/api/getAllLocations")!, method: .post, parameters: ["limit": 100, "offset": 0], encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String:AnyObject] {
                    let data = Mapper<LocationModel>().mapArray(JSONObject: JSON["result"])!
                    success(data)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
