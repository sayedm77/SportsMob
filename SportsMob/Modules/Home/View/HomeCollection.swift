//
//  HomeCollection.swift
//  SportsMob
//
//  Created by sayed mansour on 20/08/2024.
//

import UIKit
import Reachability

class HomeCollection: UICollectionViewController {
    let reachability = try! Reachability()
    var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability.whenUnreachable = { _ in
            self.displayAlert()
            print("OFFLINE")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Sports"
    }
    func displayAlert(){
        let alert : UIAlertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sport.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionCell
        let sport = viewModel.sport[indexPath.row]
        cell.imageView.image = UIImage(named: sport.image)
        cell.nameLabel.text = sport.name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (reachability.connection == .unavailable){
            displayAlert()
        } else {
            var sport : SportType = .football
            switch indexPath.row {
            case 0 : sport = .football
            case 1 : sport = .basketball
            case 2 : sport = .cricket
            case 3 : sport = .tennis
            default :
                break
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let leagueVc = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
            leagueVc.viewModel.sport = sport
            leagueVc.viewModel.checkFav = false
            self.navigationController?.pushViewController(leagueVc, animated: true)
        }
        
    }
}
