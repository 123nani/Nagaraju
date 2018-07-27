//
//  CustomTableViewCell.swift
//  Nagaraju
//
//  Created by kireeti on 25/07/18.
//  Copyright © 2018 KireetiSoftSolutions. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var sizelbl: UILabel!
    @IBOutlet var orderslbl: UILabel!
    @IBOutlet var shareslbl: UILabel!
    @IBOutlet var viewslbl: UILabel!
    @IBOutlet var Pricelbl: UILabel!
    @IBOutlet var colorlbl: UILabel!
    @IBOutlet var categorynamelbl: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
