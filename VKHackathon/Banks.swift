//
//  Banks.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation

struct BanksStruct {
    var name: String
}

class Banks {
    static let banks = [
        "CREDIT BANK OF MOSCOW" : BanksStruct(name: "МКБ"),
        "TINKOFF CREDIT SYSTEMS BANK (CJSC)" : BanksStruct(name: "Тинькофф"),
        "COMMERCIAL INNOVATION BANK ALFA-BANK" : BanksStruct(name: "Альфа-Банк"),
        "SAVINGS BANK OF THE RUSSIAN FEDERATION (SBERBANK)" : BanksStruct(name: "Сбербанк"),
        "JSCB MOSCOW INDUSTRIAL BANK" : BanksStruct(name: "Московский Индустриальный банк")
    ]
    
    static let currency = [
        "USD",
        "RUB",
        "EUR"
    ]
}
