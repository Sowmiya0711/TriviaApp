//
//  HistoryTableViewModel.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 07/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HistoryTableViewDataSource: NSObject, UITableViewDataSource {
    var realm: Realm?
    let realmData: Results<HistoryModel>
    
    init(data: Results<HistoryModel>) {
        realmData = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realmData.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath as IndexPath) as? HistoryTableViewCell
        cell?.gameDetails.text = "GAME: \(realmData[indexPath.row].timeStamp)"
        cell?.userName.text = "NAME: \(realmData[indexPath.row].name)"
        cell?.questionOne.text = realmData[indexPath.row].questionList?.questions[0].question
        cell?.answerOne.text = "Answer: \(realmData[indexPath.row].questionList?.questions[0].answer[0] ?? "")"
        cell?.questionTwo.text = realmData[indexPath.row].questionList?.questions[1].question
        cell?.answerTwo.text = "Answers: \(realmData[indexPath.row].questionList?.questions[1].answer.map{String($0)}.joined(separator: ",") ?? "")"
        return cell ?? UITableViewCell()
        
    }
    
}
