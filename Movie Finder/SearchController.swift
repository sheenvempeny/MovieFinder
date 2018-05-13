//
//  SearchController.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/10/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit

protocol SearchDelegate:NSObjectProtocol {
    
    func search(movieName:String)
}

class SearchController: NSObject {

    private lazy var searchSaver:SearchSaver = SearchSaver()
    private var searchController:UISearchController!
    private var listController:SuggestionListController!
   
    convenience init(suggestionsTableView:UITableView,resultTableView:UITableView) {
        self.init()
        self.searchController = self.makeSearchController()
        self.listController = SuggestionListController(tableView:suggestionsTableView , delegate: self)
         resultTableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.searchBar.sizeToFit()
    }
    
    private func makeSearchController() -> UISearchController{
        
        let iSearchController = UISearchController(searchResultsController: nil)
        iSearchController.searchResultsUpdater = self;
        iSearchController.dimsBackgroundDuringPresentation = false;
        iSearchController.searchBar.placeholder = NSLocalizedString("SerachMovies", comment: "")
        iSearchController.searchBar.delegate = self;
        return iSearchController
    }
    
    func saveSearch(movieName:String){
        self.searchSaver.saveSearch(movieName: movieName)
    }
}

extension SearchController:UISearchResultsUpdating{
        func updateSearchResults(for searchController: UISearchController) {
            let searchString = searchController.searchBar.text
            
        }
    }
    
extension SearchController:UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.listController.showList()
        return true
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.listController.hideList()
    }
}

extension SearchController:SuggestionListDelegate{
    func searchSelected(movieName: String) {
        
    }
}

