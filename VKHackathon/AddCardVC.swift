//
//  AddCardVC.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 09/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit


class AddCardVC: UIViewController, CardIOPaymentViewControllerDelegate {
    @IBOutlet weak var currencySegment: UISegmentedControl!
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            ServerManager.getBinFromCardNumber(info.cardNumber) { (bin) in
                let card = CardModel()
                card.bankName = (bin.bank?.name)!
                card.cardExpire = "\(info.expiryMonth)/\(info.expiryYear)"
                card.cardId = info.cardNumber
                var currency = "RUB"
                switch self.currencySegment.selectedSegmentIndex {
                case 0:
                    currency = "RUB"
                case 1:
                    currency = "USD"
                case 2:
                    currency = "EUR"
                default:
                    currency = "RUB"
                }
                card.cardCurrency = currency
                card.cardType = bin.brand ?? "Standart"
                try! realm.write {
                    realm.add(card)
                }
            }
//            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n %@", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cardImage)
//            print(str)
            //resultLabel.text = str as String
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Добавить карту"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanCard(_ sender: Any) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.collectCVV = false
        cardIOVC?.hideCardIOLogo = true
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
