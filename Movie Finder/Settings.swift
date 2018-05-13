//
//  Settings.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/8/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation

class Settings{
   
    private let searchApiKey:String = "key"
    private let searchUrlKey:String = "url"
    private let confFile:String = "SearchConf"
    static let shared = Settings()
    
    private init() {
    }
    
    private func searchDict() -> NSDictionary? {
        if let path = Bundle.main.path(forResource: confFile, ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
    
    func searchUrl() -> String? {
        return self.searchDict()?.object(forKey: searchUrlKey) as? String
    }
    func searchKey() -> String? {
        return self.searchDict()?.object(forKey: searchApiKey) as? String
    }
    
}
