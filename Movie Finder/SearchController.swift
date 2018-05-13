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
    weak var delegate:SearchDelegate?
    
    convenience init(suggestionsTableView:UITableView,resultTableView:UITableView) {
        self.init()
        self.searchController = self.makeSearchController()
        self.listController = SuggestionListController(tableView:suggestionsTableView , delegate: self)
         resultTableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.searchBar.sizeToFit()
    }
    
    private func makeSearchController() -> UISearchController{
        
        let iSearchController = UISearchController(searchResultsController: nil)
        iSearchController.dimsBackgroundDuringPresentation = false;
        iSearchController.searchBar.placeholder = NSLocalizedString("SerachMovies", comment: "")
        iSearchController.searchBar.delegate = self;
        return iSearchController
    }
    
    func saveSearch(movieName:String){
        self.searchSaver.saveSearch(movieName: movieName)
    }
    
    func resetSearchBar(){
        self.searchController.searchBar.text = ""
        self.searchController.searchBar.resignFirstResponder()
        self.listController.hideList()
    }
    
    private func showList(){
        var names:[String]?
        if let searches:[String] = self.searchSaver.searches() {
            names = searches
        }
      self.listController.showList(names:names )
    }
}

extension SearchController:UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            if searchString.count > 0 {
                self.delegate?.search(movieName: searchString)
            }
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.showList()
        return true
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.listController.hideList()
        self.resetSearchBar()
    }
}

extension SearchController:SuggestionListDelegate{
    func searchSelected(movieName: String) {
        self.delegate?.search(movieName: movieName)
    }
}

