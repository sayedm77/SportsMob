//
//  TeamDetailsVC.swift
//  SportsMob
//
//  Created by sayed mansour on 28/08/2024.
//

import UIKit
import Kingfisher
class TeamDetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel: TeamDetailsViewModel!
    
    @IBOutlet weak var noResultImgView: UIImageView!
    @IBOutlet weak var imgViewBG: UIImageView!
    @IBOutlet weak var playersTableView: UITableView!
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!

    
    required init?(coder: NSCoder) {
        self.viewModel = TeamDetailsViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        addGradientToBGImage()
        addRadiusToTeamLogo()
        configTable()
        setupIndicator()
        checkSport()
        viewModel.getTeamDetails()
    }
    
    private func addGradientToBGImage() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imgViewBG.bounds
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        imgViewBG.layer.addSublayer(gradientLayer)
    }
    
    private func addRadiusToTeamLogo() {
        logoImgView.layer.cornerRadius = 16
    }
    
    private func configTable() {
        playersTableView.delegate = self
        playersTableView.dataSource = self
        let nib = UINib(nibName: "PlayerCell", bundle: nil)
        playersTableView.register(nib, forCellReuseIdentifier: "PlayerCell")
    }
    
    private func setupIndicator() {
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func checkSport() {
        switch viewModel.getSportType() {
        case .football:
            imgViewBG.image = UIImage(named: "footballBG")
        case .basketball:
            imgViewBG.image = UIImage(named: "basketballBG")
        case .cricket:
            imgViewBG.image = UIImage(named: "cricketBG")
        case .tennis:
            imgViewBG.image = UIImage(named: "tennisBG")
        }
    }
    
    private func setupViewModel() {
        viewModel.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.logoImgView.kf.setImage(with: URL(string: self?.viewModel.team[0].teamLogo ?? ""), placeholder: UIImage(named: "teamLogo"))
                self?.teamNameLabel.text = self?.viewModel.team[0].teamName
                let coachName = self?.viewModel.team[0].coaches?[0].coachName ?? ""
                if coachName == "" {
                    self?.coachNameLabel.text = coachName
                } else {
                    self?.coachNameLabel.text = "Coach: \(coachName)"
                }
                self?.playersTableView.reloadData()
                self?.indicator.stopAnimating()
                self?.indicator.removeFromSuperview()
            }
        }
        
        viewModel.noResultFound = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator.stopAnimating()
                self?.indicator.removeFromSuperview()
                self?.noResultImgView.isHidden = false
            }
        }
    }
    
    //MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.getPlayersCount())
        return viewModel.getPlayersCount()
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.setupCell(player: viewModel.getPlayer(index: indexPath.row))
        print("heloo")
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
