//
//  PlayerCell.swift
//  SportsMob
//
//  Created by sayed mansour on 28/08/2024.
//

import UIKit
import Kingfisher

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerImgView: UIImageView!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupCell(player: Player) {
        playerImgView.kf.setImage(with: URL(string: player.playerImage ?? ""), placeholder: UIImage(named: "soccerPlayer"))
        playerNameLabel.text = player.playerName
        if player.playerNumber == "" {
            playerNumberLabel.text = "0"
        } else {
            playerNumberLabel.text = player.playerNumber
        }
    }
    
}
