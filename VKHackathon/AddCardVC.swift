//
//  AddCardVC.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 09/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit


class AddCardVC: UIViewController, CardIOPaymentViewControllerDelegate {
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let card = CardModel()
            card.bankName = ""
            card.cardExpire = "\(info.expiryMonth)/\(info.expiryYear)"
            card.cardId = info.cardNumber
            try! realm.write {
                realm.add(card)
            }
//            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n %@", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cardImage)
//            print(str)
            //resultLabel.text = str as String
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanCard(_ sender: Any) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.collectCVV = false
        cardIOVC!.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
