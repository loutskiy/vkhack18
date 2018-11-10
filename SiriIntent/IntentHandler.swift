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
        guard intent is FindAtmIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        
        return FindAtmIntentHandler()
    }

}

class FindAtmIntentHandler: NSObject, FindAtmIntentHandling {
//    func confirm(intent: FindAtmIntent, completion: @escaping (FindAtmIntentResponse) -> Void) {
//        let response = FindAtmIntentResponse(code: .success, userActivity: nil)
//
//        completion(response)
//    }
    
    func handle(intent: FindAtmIntent, completion: @escaping (FindAtmIntentResponse) -> Void) {
        print("134134")
//        FindAtmIntentResponse.success()
//        if (intent.bank) != nil && (intent.currency) != nil {
        let response = FindAtmIntentResponse(code: .success, userActivity: nil)

            completion(response)
//        }
    }
    
    
}
