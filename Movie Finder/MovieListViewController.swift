//
//  MovieListViewController.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/12/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var resultList:UITableView!
    @IBOutlet weak var suggestionList:UITableView!
    private var searchController:SearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchController = SearchController(suggestionsTableView:suggestionList , resultTableView: resultList)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
