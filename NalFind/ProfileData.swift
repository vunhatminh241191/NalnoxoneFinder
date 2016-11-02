//
//  ProfileData.swift
//  NalFind
//
//  Created by Minh Vu on 11/2/16.
//
//

import Foundation
import UIKit

class ProfileDataViewController: UIViewController {
    @IBOutlet weak var activityHistory: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        backButton.addTarget(self, action: #selector(self.backFunction), for: .touchDown)
        activityHistory.addTarget(self, action: #selector(self.activityHistoryFunction), for: .touchDown)
        editButton.addTarget(self, action: #selector(self.editProfileFunction), for: .touchDown)
    }
    
    func backFunction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func activityHistoryFunction() {
        self.performSegue(withIdentifier: "activitiyHistorySegue", sender: self)
    }
    
    func editProfileFunction() {
        
    }
    
}
