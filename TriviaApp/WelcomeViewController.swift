//
//  WelcomeViewController.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 06/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import UIKit
import RealmSwift

class WelcomeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        usernameTextField.delegate = self
    }
    
    //MARK: - On Tapping on Next Button
    @IBAction func ontapNextButton(_ sender: UIButton) {
        if let usernameTextField = self.usernameTextField.text , usernameTextField != "" {
          let quizViewController: QuizViewController = QuizViewController.instantiate(appStoryboard: .main)
          quizViewController.userName = usernameTextField
          self.navigationController?.pushViewController(quizViewController,animated: true)
        } else {
            let alert = UIAlertController(title: Constants.alertBox.alertTitle, message: Constants.alertBox.alertMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constants.alertBox.addActionTitle, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        return true
    }
}
