//
//  HomeViewModel.swift
//  SportsMob
//
//  Created by sayed mansour on 22/08/2024.
//

import Foundation
class HomeViewModel{
    var sport  : [Sports] = []
       
    init() {
        sport.append(Sports(name: "Football", image: "football"))
        sport.append(Sports(name: "Basketball", image:"basket"))
        sport.append(Sports(name: "Tennis", image:"tennis"))
        sport.append(Sports(name: "Cricket", image:"cricket"))
        }
  
}
