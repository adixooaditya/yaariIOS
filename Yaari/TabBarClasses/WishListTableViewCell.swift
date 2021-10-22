//
//  WishListTableViewCell.swift
//  Yaari
//
//  Created by Mac on 27/09/21.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    @IBOutlet weak var btnViewDetails: UIButton!
    @IBOutlet weak var heightConstraintDetails: NSLayoutConstraint!
    
    @IBOutlet weak var viewDetails: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
