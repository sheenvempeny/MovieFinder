//
//  SearchSaver.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/12/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation
import UIKit

class SearchSaver{
    
    lazy var dataManager:CoreDataManager = self.getDataManager()
    
    private func getDataManager() -> CoreDataManager{
        
        if let appDelegate:AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            let dataManager:CoreDataManager = appDelegate.dataManager
            return dataManager
        }
        
        return CoreDataManager()
    }
    
    func saveSearch(movieName:String){
       // use   a   different   persistent   store   (Core   Data,   SQLite,   iCloud,   FMDB)
       self.dataManager.saveMovieSearch(name: movieName, date: Date())
    }
    
    func searches() ->[String]?{
        return self.dataManager.searches()
    }
}
