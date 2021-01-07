//
//  SummaryViewController.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 07/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import UIKit
import RealmSwift

class SummaryViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstQuestion: UILabel!
    @IBOutlet weak var firstQuestionAnswer: UILabel!
    @IBOutlet weak var secondQuestion: UILabel!
    @IBOutlet weak var secondQuestionAnswer: UILabel!
    
    var realm: Realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realmResult = realm.objects(HistoryModel.self)
        navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        navigationController?.navigationBar.tintColor = UIColor.white
        userNameLabel.text = "Hello \(realmResult.last?.name ?? "")"
        firstQuestion.text = realmResult.last?.questionList?.questions[0].question
        firstQuestionAnswer.text = realmResult.last?.questionList?.questions[0].answer[0]
        secondQuestion.text = realmResult.last?.questionList?.questions[1].question
        secondQuestionAnswer.text =  realmResult.last?.questionList?.questions[1].answer.map{String($0)}.joined(separator: ",")
    }

    @IBAction func onTapFinish(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapHistory(_ sender: Any) {
         let historyViewController: HistoryViewController = HistoryViewController.instantiate(appStoryboard: .main)
                          
        self.navigationController?.pushViewController(historyViewController,animated: true)
    }
}
