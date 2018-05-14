//
//  SuggestionListController.swift
//  Movie Finder
//
//  Created by sheen vempeny on 5/10/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import UIKit

protocol SuggestionListDelegate:NSObjectProtocol {
    
    func searchSelected(movieName:String)
}

class SuggestionListController: NSObject {

    private weak var tableView:UITableView!
    private weak var delegate:SuggestionListDelegate!
    private var names:[String]?
    
    convenience init(tableView:UITableView,delegate:SuggestionListDelegate) {
        self.init()
        self.delegate = delegate
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.hideList()
    }
    
    func hideList()  {
        self.tableView.isHidden = true
    }
    func showList(names:[String]?)  {
        self.names = names
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
}

extension SuggestionListController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath)
        cell.textLabel?.text = self.names![indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedName = self.names![indexPath.row]
        self.delegate.searchSelected(movieName: selectedName)
    }
}
