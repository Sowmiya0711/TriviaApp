//
//  KnowledgeCheckViewController.swift
//  ScrollViewProject
//
//  Created by Sowmiya  on 4/8/20.
//  Copyright © 2021 Sowmiya . All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: UIViewController {
    
    @IBOutlet weak var collectionViews: UICollectionView!
    @IBOutlet weak var questionBarCollection: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: var
    var questionListModel: QuestionsListModel?
    var currentQuestionNumber = 0
    var historyModel: HistoryModel?
    var realm: Realm?
    var userName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        navigationController?.navigationBar.tintColor = UIColor.white
        collectionViews.register(UINib(nibName: Constants.QuizViewController.CollectionViews.HeaderView.nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.QuizViewController.CollectionViews.HeaderView.reuseIdentifier)
       
        currentQuestionNumber = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       navigationController?.navigationBar.isHidden = false
        historyModel = HistoryModel()
       realm = try! Realm()
        collectionViews.allowsMultipleSelection = false
        currentQuestionNumber = 0
        nextButton.isEnabled = false
        do {
        try realm?.write{
            guard let id = historyModel?.incrementID() else { return }
            historyModel?.id = id
            historyModel?.name = userName ?? ""
               }
        }catch {
            print(error)
        }
        readJsonFile()
        collectionViews.reloadData()
        questionBarCollection.reloadData()
       
    }
    
    func readJsonFile() {
        if let path = Bundle.main.path(forResource: "QuestionList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
             
                do {
                    let questions = try JSONDecoder().decode(QuestionsListModel.self, from: data)
                    
                    questionListModel = questions
                
                   } catch {
                       print(error)
                   }
              } catch {
                   print(error)
              }
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        nextButton.isEnabled = false
        if let questionCount = questionListModel?.questions.count, currentQuestionNumber < questionCount - 1   {
            currentQuestionNumber += currentQuestionNumber >= questionCount ? 0 : 1
            
                let collectionBounds = self.collectionViews.bounds
                var contentOffset: CGFloat = 0
                contentOffset = CGFloat(floor(self.collectionViews.contentOffset.x + collectionBounds.size.width))
                
                self.moveToFrame(contentOffset: contentOffset)
             collectionViews.allowsMultipleSelection = true
        } else {
            try! realm?.write {
                historyModel?.questionList = questionListModel
                let currentDate = Date()
                let dateFormatter = DateFormatter()

                dateFormatter.dateFormat = currentDate.dateFormatWithSuffix()
                let convertedDate: String = dateFormatter.string(from: currentDate)
                historyModel?.timeStamp = convertedDate
                if let historyModel = historyModel {
                    realm?.add(historyModel)
                }
                
            }
             let summaryViewController: SummaryViewController = SummaryViewController.instantiate(appStoryboard: .main)
                   
            self.navigationController?.pushViewController(summaryViewController,animated: true)
        }
    }
   
    private func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionViews.contentOffset.y ,width : self.collectionViews.frame.width,height : self.collectionViews.frame.height)
        self.collectionViews.reloadData()
        self.questionBarCollection.reloadData()
        self.collectionViews.scrollRectToVisible(frame, animated: true)
    }
    
}

extension QuizViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == questionBarCollection {
            if let questionCount = questionListModel?.questions.count {
                    return Int(questionCount)
                }
                
            } else if collectionView == collectionViews {
                    return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == questionBarCollection {
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: Constants.QuizViewController.QuestionBarCollectionView.collectionViewCellReuseIdentifier, for: indexPath) as! QuestionbarCollectionViewCell
            
            cell.questionNumber.text = String(indexPath.row + 1)
           
            
            if currentQuestionNumber == indexPath.row {
                cell.circularView.layer.cornerRadius = cell.frame.size.width/2.0
                cell.circularView.layer.masksToBounds = true
                cell.circularView.backgroundColor = UIColor(red: 42/255, green: 182/255, blue: 90/255, alpha: 1)
                cell.questionNumber.textColor = UIColor.white
            } else {
                cell.circularView.backgroundColor = UIColor.clear
                cell.questionNumber.textColor = UIColor.init(red: 162/255, green: 162/255, blue: 162/255, alpha: 1)
            }
            return cell
        } else {
            let question = questionListModel?.questions[currentQuestionNumber]
              guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: Constants.QuizViewController.CollectionViews.collectionViewCellReuseIdentifier, for: indexPath) as? QuestionCollectionViewCell else {
                    fatalError("unexpected indexpathh")
                }
            cell.optionLabel.text = question?.options[indexPath.row]
            return cell
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        do {
            try? realm?.write {
            questionListModel?.questions[currentQuestionNumber].answer.append((questionListModel?.questions[currentQuestionNumber].options[indexPath.row])!)
            nextButton.isEnabled = currentQuestionNumber == 0 ? true : false
            nextButton.isEnabled = (currentQuestionNumber == 1 && (questionListModel?.questions[currentQuestionNumber].answer.count == 4)) || currentQuestionNumber == 0 ? true : false
        }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
                if let index = questionListModel?.questions[currentQuestionNumber].answer.firstIndex(of: (questionListModel?.questions[currentQuestionNumber].options[indexPath.row])!) {
                    questionListModel?.questions[currentQuestionNumber].answer.remove(at: index)
                }
               
                return false
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == questionBarCollection {
                return CGSize(width:40, height: 40)
        } else {
               let lay = collectionViewLayout as? UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 1 - lay!.minimumInteritemSpacing
                return CGSize(width:widthPerItem, height: 60)
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if collectionView == collectionViews {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath as IndexPath) as? HeaderView
            headerView?.questionLabel.text = questionListModel?.questions[currentQuestionNumber].question
            headerView?.frame.size.height = 100
            
            return headerView ?? UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == collectionViews {
            return CGSize(width: collectionViews.frame.width, height: 100.0)
        }
        return CGSize(width: 0, height: 0)
    }
    
    
    @objc func onTapOfCorrectButton(_ sender: UIButton) {
        collectionViews.reloadData()
    }
    
}

