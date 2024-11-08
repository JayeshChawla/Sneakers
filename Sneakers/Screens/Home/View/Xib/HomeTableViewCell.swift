//
//  HomeTableViewCell.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var buyNowLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
