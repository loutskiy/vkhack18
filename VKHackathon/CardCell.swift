//
//  CardCell.swift
//  VKHackathon
//
//  Created by Mikhail Lutskiy on 09/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var cardHoldImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
