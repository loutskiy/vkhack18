//
//  ServerManager.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {
    static let shared = ServerManager()
    
    static func getBinFromCardNumber(_ number: String, success: @escaping(_ binModel: BinModel) -> Void) {
        Alamofire.request(URL(string: "https://lookup.binlist.net/\(number)")!).responseJSON { (response) in
            
        }
    }
}
