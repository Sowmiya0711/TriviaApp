//
//  HistoryViewController.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 07/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
  
    var currentDataSource: UITableViewDataSource? {
      didSet {
        self.historyTableView.dataSource = currentDataSource
        self.historyTableView.reloadData()
      }
    }
    
    var realm: Realm = try! Realm()
       
       override func viewDidLoad() {
           super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        navigationController?.navigationBar.tintColor = UIColor.white
           let realmResult = realm.objects(HistoryModel.self)
        super.viewDidLoad()
        //MARK: Assigning Data Source
        self.currentDataSource = HistoryTableViewDataSource(data: realmResult)
    }
}
