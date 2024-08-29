//
//  TeamDetailsVC.swift
//  SportsMob
//
//  Created by sayed mansour on 28/08/2024.
//

import UIKit

class TeamDetailsVC: UIViewController , UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var noResultImgView: UIImageView!
    @IBOutlet weak var imgViewBG: UIImageView!
    @IBOutlet weak var playersTableView: UITableView!
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.dataSource = self
        playersTableView.delegate = self
    }
    


}
