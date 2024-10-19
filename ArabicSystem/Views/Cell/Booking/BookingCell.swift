//
//  BookingCell.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var lbl_CategoryName: UILabel!
    @IBOutlet weak var lbl_AllBookingDetails: UILabel!
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var lbl_CurrentStatus: UILabel!
    
    @IBOutlet weak var btn_RatingOt: UIButton!
    @IBOutlet weak var btn_SeeDetails: UIButton!
    
    @IBOutlet weak var btn_Blank1: UIButton!
    @IBOutlet weak var btn_Blank2: UIButton!
    
    var clo_Rate: (() -> Void)?
    var clo_SeeDetails: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func btn_GiveRating(_ sender: UIButton) {
        self.clo_Rate?()
    }
    
    @IBAction func btn_SeeDetails(_ sender: UIButton) {
        clo_SeeDetails?()
    }
}
