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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    func search(movieName: String) {
        self.fetcher.searchMovie(name: movieName, pageNum: 1) { (result:PageResult?, status:Bool) in
            if (status == true){
                print(movieName)
                print(result?.total_results ?? 0)
                self.searchController.saveSearch(movieName:movieName)
            }
            else{
                print("error")
            }
        }
    }
}

extension MovieListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
}

