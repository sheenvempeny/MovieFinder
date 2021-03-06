//
//  MovieCell.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/9/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

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
        cell.lblReleaseDate.text = NSLocalizedString("MovieReleasedDate", comment: "")   + info.release_date
        cell.lblOverview.text = info.overview
        if info.posterUrl != nil {
            cell.imgMoviePoster.kf.setImage(with: info.posterUrl)
        }
    }
}

extension UIViewController{
    
    func showAlert(message:String){
        
        let alertController = UIAlertController(title: "Movie Finder", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

