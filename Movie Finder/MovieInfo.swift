//
//  MovieInfo.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/9/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation

class MovieInfo:Decodable {
    
    let title: String
    let overview: String
    let release_date: String
    var posterUrl:URL?
    
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case release_date = "release_date"
        case poster_path = "poster_path"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        overview = try values.decodeIfPresent(String.self, forKey: .overview)  ?? ""
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date) ?? ""
        if let posterPath = try values.decodeIfPresent(String.self, forKey: .poster_path) {
            posterUrl =  URL(string: Settings.shared.posterUrl()! + posterPath)
        }
    }
    
}

class PageResult:Decodable{
    
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        total_results = try values.decode(Int.self, forKey: .total_results)
        total_pages = try values.decode(Int.self, forKey: .total_pages)
        results = try values.decode([MovieInfo].self, forKey: .results)
    }
}
