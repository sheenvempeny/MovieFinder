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
   
    private var currentPage:Int?
    private var totalPages:Int?
    private var movieName:String?
    
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
            //There is an error or no movies found for the search
            if (pageNum == 1 && (status == false || (status == true && result!.total_results == 0))){
                self.searchController.resetSearchBar()
                self.showAlert(message: NSLocalizedString("NoMoviesError", comment: ""))
                self.currentPage = nil
                self.totalPages = nil
                self.movieName = nil
                self.resultList.reloadData()
                return
            }
            
            //Search is successful,saving the name
            if (pageNum == 1 && result!.total_results > 0) {
                self.searchController.saveSearch(movieName:movieName)
                self.movieName = movieName
            }
            
            //Reloading the table view
            self.currentPage = pageNum
            self.totalPages = result!.total_pages
            
            self.searchController.resetSearchBar()
            self.movies.append(contentsOf: result!.results)
            self.resultList.reloadData()
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.movies.count {
            if (self.currentPage! < self.totalPages!){
                
                self.searchMovie(movieName: self.movieName!, pageNum: self.currentPage! + 1)
            }
            
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

