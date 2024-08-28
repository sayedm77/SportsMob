//
//  LeaguesViewController.swift
//  SportsMob
//
//  Created by sayed mansour on 22/08/2024.
//

import UIKit
import Reachability
import CoreData
import SDWebImage


class LeaguesViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = LeaguesViewModel()
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "LeaguesCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        reachability.whenUnreachable = { _ in
            self.displayAlert()
            print("OFFLINE")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        fetchLeagues()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Favourite"
        fetchLeagues()
       
       
    }
    
    func displayAlert(){
        let alert : UIAlertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func navigateToSafari(for index: Int) {
        if let url = self.viewModel.getYouTubeChannelURL(for: index) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func fetchLeagues(){
        // show indector
        viewModel.onLeaguesFetched = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
             
            }
            
        }
        viewModel.getLeagues()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "GoToDetails" {
              if let destinationVC = segue.destination as? LeagueDetailsVC {
                  let index = sender as! Int
                  destinationVC.viewModel.league = viewModel.getLeague(index: index )
                  destinationVC.viewModel.sport = viewModel.sport
              }
          }
      }
    
    private func navigateToSafari(_ index: Int) {
        if let url = self.viewModel.getYouTubeChannelURL(for: index) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfLeagues()
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCell
        let league = viewModel.leagues[indexPath.row]
        cell.setupCell(league: league)
        cell.buttonTapped = {
            self.navigateToSafari(indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (reachability.connection == .unavailable){
            displayAlert()
        }else{
            self.performSegue(withIdentifier: "GoToDetails", sender: indexPath.row)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
