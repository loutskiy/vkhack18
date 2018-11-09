//
//  CardModel.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 09/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import RealmSwift

class CardModel: Object {
    @objc dynamic var bankName = ""
    @objc dynamic var cardId = ""
    @objc dynamic var cardExpire = ""
}
