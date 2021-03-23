//
//  TVCells.swift
//  takeit_top
//
//  Created by Lee on 2021/3/8.
//

import UIKit

class TVCells: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    
    @IBOutlet var labelCell01: UILabel!
    
    @IBOutlet var labelCell02: UILabel!
    
    @IBOutlet var labelCell03: UILabel!
    
    @IBOutlet var labelCell04: UILabel!
    
    @IBOutlet var labelCell05: UILabel!
    
    var task: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        imageViewCell.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedBackgroundView?.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.4, alpha: 1)
        
        // Configure the view for the selected state
    }

}
