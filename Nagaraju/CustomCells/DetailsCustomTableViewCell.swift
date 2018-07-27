//
//  DetailsCustomTableViewCell.swift
//  Nagaraju
//
//  Created by kireeti on 26/07/18.
//  Copyright © 2018 KireetiSoftSolutions. All rights reserved.
//

import UIKit

class DetailsCustomTableViewCell: UITableViewCell {

    @IBOutlet var btnbuy: UIButton!
    @IBOutlet var pricelbl: UILabel!
    @IBOutlet var sizelbl: UILabel!
    @IBOutlet var colorlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
