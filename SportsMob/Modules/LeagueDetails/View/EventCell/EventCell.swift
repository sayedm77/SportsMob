//
//  EventCell.swift
//  SportsMob
//
//  Created by sayed mansour on 26/08/2024.
//

import UIKit
import Kingfisher

class EventCell: UICollectionViewCell {

    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
    }
    func setupCell(event: EventModel) {
        homeImage.kf.setImage(with: URL(string: event.homeTeamLogo ?? ""), placeholder: UIImage(named: "leagueLogo"))
        homeLabel.text = event.eventHomeTeam
        awayImage.kf.setImage(with: URL(string: event.awayTeamLogo ?? ""), placeholder: UIImage(named: "leagueLogo"))
        awayLabel.text = event.eventAwayTeam
        //        leagueImage.kf.setImage(with: URL(string: event.leagueLogo ?? ""), placeholder: UIImage(named: "leagueLogo"))
        scoreLabel.text = event.eventFinalResult
        dateLabel.text = event.eventDate
        timeLabel.text = event.eventTime
        
        if event.eventFinalResult == "-" {
            scoreLabel.text = " "
        }
    }
    

}
