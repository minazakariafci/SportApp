//
//  LegueTableViewCell.swift
//  SportApp
//
//  Created by mac on 3/23/21.
//

import UIKit

class LegueTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var legueImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        legueImageView.maskCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
