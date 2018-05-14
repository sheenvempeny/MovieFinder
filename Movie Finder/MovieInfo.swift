//
//  MovieInfo.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/9/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation

class MovieInfo:Codable {
    
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
 
    var posterUrl:URL{
        get{
            return URL(string: Settings.shared.posterUrl()! + self.poster_path)!
        }
    }
    
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case release_date = "release_date"
        case poster_path = "poster_path"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(release_date, forKey: .release_date)
        try container.encode(poster_path, forKey: .poster_path)
    }
    
    init(title: String, overview: String,release_date:String,poster_path:String) {
        self.title = title
        self.overview = overview
        self.release_date = release_date
        self.poster_path = poster_path
    }
    
}

class PageResult:Codable{
    
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results:[MovieInfo]
    
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case total_results = "total_results"
        case total_pages = "total_pages"
        case results = "results"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(total_results, forKey: .total_results)
        try container.encode(total_pages, forKey: .total_pages)
        try container.encode(results, forKey: .results)
    }
    
    init(page: Int, total_results: Int,total_pages:Int,results:[MovieInfo]) {
        self.page = page
        self.total_results = total_results
        self.total_pages = total_pages
        self.results = results
        
    }
}
