//
//  IntentHandler.swift
//  SiriIntent
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        print("rqeferf")
        return self
    }

}

extension IntentHandler: FindAtmIntentHandling {
    func handle(intent: FindAtmIntent, completion: @escaping (FindAtmIntentResponse) -> Void) {
        print("134134")
//        if (intent.bank) != nil && (intent.currency) != nil {
            let response = FindAtmIntentResponse(code: FindAtmIntentResponseCode.successWithRoad, userActivity: nil)
            
            completion(response)
//        }
    }
    
    
}
