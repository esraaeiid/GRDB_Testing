//
//  TextTableViewCell.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 12/02/2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtFiled: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
