//
//  HeaderView.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 06/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
