//
//  NotifyCell.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit

class NotifyCell: UITableViewCell {

    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
