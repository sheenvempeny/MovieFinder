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
    
    convenience init(tableView:UITableView,delegate:SuggestionListDelegate) {
        self.init()
        self.delegate = delegate
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.red
        self.hideList()
    }
    
    func hideList()  {
        self.tableView.isHidden = true
    }
    func showList()  {
        self.tableView.isHidden = false
    }
}

extension SuggestionListController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        return UITableViewCell()
    }

}
