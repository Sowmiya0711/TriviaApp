//
//  Constants.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 06/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation

struct Constants {
struct QuizViewController {
    struct CollectionViews {
        struct HeaderView {
            static let nibName = "HeaderView"
            static let reuseIdentifier = "HeaderView"
            
        }
        
        static let collectionViewCellReuseIdentifier = "Cell"
    }
    
    struct QuestionBarCollectionView {
        static let collectionViewCellReuseIdentifier = "QuestionBarCollectionViewCell"
    }
    static let emptyString = ""
}
    
    struct alertBox {
        static let alertTitle = "Alert"
        static let alertMessage = "Please Enter Your Name"
        static let addActionTitle = "OK"
    }
}
