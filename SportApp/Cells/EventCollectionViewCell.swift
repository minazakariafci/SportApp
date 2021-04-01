//
//  EventCollectionViewCell.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homaLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        homeImageView.maskCircle()
        awayImageView.maskCircle()
        // Initialization code
    }

}
