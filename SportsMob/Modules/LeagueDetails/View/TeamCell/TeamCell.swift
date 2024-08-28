//
//  TeamCell.swift
//  SportsMob
//
//  Created by sayed mansour on 26/08/2024.
//

import UIKit
import Kingfisher

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemBrown.cgColor
    }
    func setupCell(team: TeamModel) {
        teamLabel.text = team.teamName
        teamImage.kf.setImage(with: URL(string: team.teamLogo ?? ""), placeholder: UIImage(named: "teamLogo"))
    }
    


}
