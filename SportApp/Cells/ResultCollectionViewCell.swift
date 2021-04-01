//
//  ResultCollectionViewCell.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var homeResultLabel: UILabel!
    @IBOutlet weak var awayResultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var homeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        homeImageView.maskCircle()
        awayImageView.maskCircle()
        homeResultLabel.maskCircle()
        awayResultLabel.maskCircle()
        // Initialization code
    }

}
