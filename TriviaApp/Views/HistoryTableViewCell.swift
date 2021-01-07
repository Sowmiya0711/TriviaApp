//
//  HistoryTableViewCell.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 07/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameDetails: UILabel!
    @IBOutlet weak var questionOne: UILabel!
    @IBOutlet weak var answerOne: UILabel!
    @IBOutlet weak var questionTwo: UILabel!
    @IBOutlet weak var answerTwo: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
