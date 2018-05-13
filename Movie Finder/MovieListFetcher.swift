//
//  MovieListFetcher.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/8/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation
import Alamofire

typealias SearchMovieHandler = (_ result:PageResult?,_ isSuccess:Bool) -> Void

class MovieListFetcher{
    
    func searchMovie(name:String,pageNum:Int,handler:@escaping SearchMovieHandler){
        
        guard let urlString = Settings.shared.searchUrl(),let key = Settings.shared.searchKey() else {
            //issues in settings
            handler(nil, false)
            return
        }
        
        let parameters: Parameters = ["api_key": key,"query":name,"page":pageNum]
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        Alamofire.request(urlString,method: .get, parameters: parameters,encoding:URLEncoding.queryString, headers: headers).responseJSON { response in
            
            guard let data = response.data else{
                //issues in response data
                handler(nil, false)
                return
            }
            
            do {
                //Convert to PageResult object
                let decoder = JSONDecoder()
                let result = try decoder.decode(PageResult.self, from: data)
               //successful parsing
                handler(result, true)
            } catch {
                //Error in Decoding
                handler(nil, false)
            }
            
        }
        
        
        
    }
    
    
}
