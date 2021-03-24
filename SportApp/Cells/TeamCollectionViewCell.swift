//
//  TeamCollectionViewCell.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        teamImageView.maskCircle()
        
        // Initialization code
    }
    
}
