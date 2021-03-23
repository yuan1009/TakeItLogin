//
//  CinemaTableViewCell.swift
//  TastURLSession
//
//  Created by mac on 2021/3/2.
//

import UIKit

class CinemaTableViewCell: UITableViewCell {

    @IBOutlet weak var cinemaLable: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeOneLabel: UILabel!
    @IBOutlet weak var timeTwoLabel: UILabel!
    @IBOutlet weak var timeThreeLabel: UILabel!
    @IBOutlet weak var timeFourLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
