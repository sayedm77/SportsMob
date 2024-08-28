//
//  CoreDataService.swift
//  SportsMob
//
//  Created by sayed mansour on 28/08/2024.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func addLeague(league: Leagues, sport: SportType)
    func fetchLeagues() -> ([Leagues], [SportType])
    func deleteLeague(leagueKey: Int, sport: SportType)
    func checkFav(leagueKey: Int, sport: SportType) -> Bool
}

class CoreDataService: CoreDataServiceProtocol {
    static let shared = CoreDataService()
    let appDelegate: AppDelegate
    let managedContext: NSManagedObjectContext
    
    private init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    private func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func addLeague(league: Leagues, sport: SportType) {
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: managedContext)
        let leagueObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagueObject.setValue(league.league_key, forKey: "leagueKey")
        leagueObject.setValue(league.league_name, forKey: "leagueName")
        leagueObject.setValue(league.country_key, forKey: "countryKey")
        leagueObject.setValue(league.country_name, forKey: "countryName")
        leagueObject.setValue(league.league_logo, forKey: "leagueLogo")
        leagueObject.setValue(league.country_logo, forKey: "countryLogo")
        leagueObject.setValue(league.league_year, forKey: "leagueYear")
        leagueObject.setValue(sport.rawValue, forKey: "sport")
        saveContext()
    }
    
    func fetchLeagues() -> ([Leagues], [SportType]) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"FavouriteLeagues")
        
        var leagues = [Leagues]()
        var sports = [SportType]()
        do {
            let leagueObjects = try managedContext.fetch(fetchRequest)
            for leagueObject in leagueObjects {
                let league = Leagues(
                    league_key: leagueObject.value(forKey: "leagueKey") as! Int,
                    league_name: leagueObject.value(forKey: "leagueName") as! String,
                    country_key: leagueObject.value(forKey: "countryKey") as! Int?,
                    country_name: leagueObject.value(forKey: "countryName") as! String?,
                    league_logo: leagueObject.value(forKey: "leagueLogo") as! String?,
                    country_logo: leagueObject.value(forKey: "countryLogo") as! String?,
                    league_year: leagueObject.value(forKey: "leagueYear") as! String?
                )
                let sportRawValue = leagueObject.value(forKey: "sport") as! String
                let sport = SportType(rawValue: sportRawValue) ?? .football
                leagues.append(league)
                sports.append(sport)
            }
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return (leagues, sports)
    }
    
    func deleteLeague(leagueKey: Int, sport: SportType) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"FavouriteLeagues")
        let myPredicate = NSPredicate(format: "leagueKey == %d && sport == %@", leagueKey, sport.rawValue)
        fetchRequest.predicate = myPredicate
        do {
            let leagues = try managedContext.fetch(fetchRequest)
            if !leagues.isEmpty {
                managedContext.delete(leagues[0])
            }
            saveContext()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func checkFav(leagueKey: Int, sport: SportType) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"FavouriteLeagues")
        let myPredicate = NSPredicate(format: "leagueKey == %d && sport == %@", leagueKey, sport.rawValue)
        fetchRequest.predicate = myPredicate
        
        do {
            let leagueObjects = try managedContext.fetch(fetchRequest)
            return !leagueObjects.isEmpty
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return false
    }
    
}
