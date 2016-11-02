//
//  QuestionMark.swift
//  NalFind
//
//  Created by Minh Vu on 11/2/16.
//
//

import Foundation
import UIKit

class QuestionMarkViewController: UIViewController {
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var nameOfQuestion: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var questionName: String!
    
    override func viewDidLoad() {
        nameOfQuestion.text = questionName.components(separatedBy: "? ")[1]
        answer.text = NSLocalizedString(questionName, comment: "")
        print(answer.text)
        backButton.addTarget(self, action: #selector(self.backFunction), for: .touchDown)
        
    }
    
    func backFunction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
