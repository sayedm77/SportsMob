//
//  NoEventCell.swift
//  SportsMob
//
//  Created by sayed mansour on 26/08/2024.
//

import UIKit

class NoEventCell: UICollectionViewCell {
    @IBOutlet weak var noEventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
        noEventImage.layer.cornerRadius = 16
    }

}
