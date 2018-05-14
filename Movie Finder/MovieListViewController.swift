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
    private var fetcher:MovieListFetcher!
    private var movies:[MovieInfo]!
    private var cellUpdator:MovieCellUpdator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.cellUpdator = MovieCellUpdator()
        self.movies = []
        self.fetcher = MovieListFetcher()
        self.searchController = SearchController(suggestionsTableView:suggestionList , resultTableView: resultList)
        self.searchController.delegate = self
        self.resultList.delegate = self
        self.resultList.dataSource = self
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

extension MovieListViewController:SearchDelegate{
    
    func searchMovie(movieName: String,pageNum:Int){
        
        self.fetcher.searchMovie(name: movieName, pageNum: pageNum) { (result:PageResult?, status:Bool) in
            if (status == true){
                self.movies.append(contentsOf: result!.results)
                if (result!.page == 1) {
                    self.searchController.saveSearch(movieName:movieName)
                }
                DispatchQueue.main.async {
                    self.searchController.resetSearchBar()
                    self.resultList.reloadData()
                    
                }
                
            }
            else{
                print("error")
            }
        }

    }
    
    func search(movieName: String) {
        self.movies = []
        self.searchMovie(movieName: movieName, pageNum: 1)
    }
}

extension MovieListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let info:MovieInfo = self.movies[indexPath.row]
        self.cellUpdator.update(cell: cell, info: info)
        return cell
    }
}
