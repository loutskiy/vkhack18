//
//  GetMoney.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 10/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import RealmSwift

class GetMoney: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var currencySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var data: Results<CardModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        data = realm.objects(CardModel.self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeTracking(_ sender: UISwitch) {
        var currency = "RUB"
        switch currencySegment.selectedSegmentIndex {
        case 0:
            currency = "RUB"
        case 1:
            currency = "USD"
        case 2:
            currency = "EUR"
        default:
            currency = "RUB"
        }
//        UserDefaults.standard.set(currency, forKey: "currency")
//        UserDefaults.standard.set(sender.isOn, forKey: "is_on")
        NotificationTrackerSingleton.shared.currency = currency
        NotificationTrackerSingleton.shared.isTrackLocation = sender.isOn
        NotificationTrackerSingleton.shared.sendingToServer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = data![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GetMoneyCell
        cell.titleField.text = card.cardId.inserting(separator: "    ", every: 4)
        return cell
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
