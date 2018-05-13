//
//  MovieCell.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/9/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation
import UIKit

class MovieCell:UITableViewCell{
    /* list   view   with   the   following   rows
     i. Movie   Poster
     ii. Movie   name
     iii. Release   date
     iv. Full   Movie   Overview*/
    @IBOutlet weak var imgMoviePoster:UIImageView!
    @IBOutlet weak var lblMovieName:UILabel!
    @IBOutlet weak var lblReleaseDate:UILabel!
    @IBOutlet weak var lblOverview:UILabel!
}

class MovieCellUpdator: NSObject {
    
    func update(cell:MovieCell,info:MovieInfo){
        cell.lblMovieName.text = info.title
        cell.lblReleaseDate.text = info.release_date
        cell.lblOverview.text = info.overview
        cell.imgMoviePoster.image = UIImage()
    }
}
