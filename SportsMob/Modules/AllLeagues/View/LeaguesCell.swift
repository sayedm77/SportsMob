//
//  LeaguesCell.swift
//  SportsMob
//
//  Created by sayed mansour on 23/08/2024.
//

import UIKit
import Kingfisher

class LeaguesCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    var buttonTapped :(() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImage.layer.cornerRadius = myImage.frame.width / 2.5
        myImage.clipsToBounds = true
        myImage.layer.borderWidth = 0.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func youtubeButton(_ sender: Any) {
        buttonTapped?()
    }

    func setupCell(league: Leagues) {
        label.text = league.league_name
        myImage.kf.setImage(with: URL(string: league.league_logo ?? ""), placeholder: UIImage(named: "leagueLogo"))
    }
    
}
