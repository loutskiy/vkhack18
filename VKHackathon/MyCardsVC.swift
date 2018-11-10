//
//  MyCardsVC.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 09/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import RealmSwift
import Intents

class MyCardsVC: UITableViewController {
    
    var cards: Results<CardModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationTrackerSingleton.shared.sendingToServer()
        donateInteraction()
//        setupIntents()
        INPreferences.requestSiriAuthorization { (status) in
        }
        self.tableView.tableFooterView = UIView()
        cards = realm.objects(CardModel.self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func donateInteraction() {
        let intent = FindAtmIntent()
        
        intent.suggestedInvocationPhrase = "Хочу снять деньги с карты сбербанк в рублях"
        intent.bank = "сбербанк"
        intent.currency = "долларах"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }
//
//    func setupIntents() {
//        for bank in Banks.banks {
//            for currency in Banks.currency {
//                print(bank.key + currency)
//                let activity = NSUserActivity(activityType: bank.key + currency) // 1
//                activity.title = bank.value.name + " " + currency // 2
//                activity.userInfo = ["speech" : "Привет " + bank.value.name + " " + currency] // 3
//                activity.isEligibleForSearch = true // 4
//                activity.isEligibleForPrediction = true // 5
//                activity.persistentIdentifier = bank.key + currency // 6
//                view.userActivity = activity // 7
//                activity.becomeCurrent() // 8
//            }
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = cards![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardCell
        cell.cardNumberLabel.text = card.cardId.inserting(separator: "    ", every: 4)
        cell.expiryLabel.text = card.cardExpire
        cell.bankLabel.text = Banks.banks[card.bankName]?.name ?? ""
        switch card.cardCurrency {
        case "RUB":
            cell.currencyLabel.text = "₽"
        case "USD":
            cell.currencyLabel.text = "$"
        case "EUR":
            cell.currencyLabel.text = "€"
        default:
            cell.currencyLabel.text = "₽"
        }
        if card.cardType == "Gold" {
            cell.cardHoldImage.image = #imageLiteral(resourceName: "card_gold")
        }
        // Configure the cell...

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(cards![indexPath.row])
            }
        
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards![indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.isNeedFilter = true
        vc.bankName = card.bankName
        vc.currency = card.cardCurrency
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    public func sayHi() {
        let alert = UIAlertController(title: "Hi There!", message: "Hey there! Glad to see you got this working!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
