//
//  QuestionCollectionViewCell.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 06/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation
import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var optionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = 2.0
            self.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
        }
    }
}
