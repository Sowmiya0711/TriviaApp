//
//  QuestionListModel.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 06/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class HistoryModel: Object {
     @objc dynamic var questionList: QuestionsListModel?
    @objc dynamic var name = ""
    @objc dynamic var timeStamp = ""
    @objc dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(HistoryModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}


// MARK: - QuestionListModel
class QuestionsListModel: Object, Codable {
    var questions = List<Question>()
    
    
    required convenience init(from decoder: Decoder) throws {
           self.init()
         let values = try decoder.container(keyedBy: CodingKeys.self)
        let questions = try values.decodeIfPresent([Question].self,forKey: .questions) ?? []
              self.questions.append(objectsIn: questions)
           
       }
       
       required init(value: Any, schema: RLMSchema)
       {
           fatalError("init(realm:schema:) has not been implemented")
       }
       
       required init(realm: RLMRealm, schema: RLMObjectSchema)
       {
           fatalError("init(value:schema:) has not been implemented")
       }
    
    required init() {
        super.init()
        
    }
}

// MARK: - Question
 class Question: Object,Codable {
   @objc dynamic var number: Int
  @objc  dynamic var question: String
   let options = List<String>()
    @objc dynamic let answerType: String
    var answer = List<String>()
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case question = "question"
        case options = "options"
        case answer
        case answerType = "answer_type"
    }
    
    required convenience init(from decoder: Decoder) throws {
              self.init()
            let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decodeIfPresent(String.self, forKey: .question) ?? ""
        number = try values.decodeIfPresent(Int.self, forKey: .number) ?? 0
           let options = try values.decodeIfPresent([String].self,forKey: .options) ?? []
                 self.options.append(objectsIn: options)
              let answer = try values.decodeIfPresent([String].self,forKey: .answer) ?? []
        self.answer.append(objectsIn: answer)
          }
    
    required init()
    {
        self.number = 0
        self.question = ""
        self.answerType = ""
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        fatalError("init(value:schema:) has not been implemented")
    }
   
}
