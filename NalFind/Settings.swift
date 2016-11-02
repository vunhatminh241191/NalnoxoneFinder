//
//  Settings.swift
//  NalFind
//
//  Created by Minh Vu on 10/31/16.
//
//

import Foundation
import UIKit
import M13Checkbox

class SettingsViewController: UIViewController {
    @IBOutlet weak var checkingToChangeCarrier: M13Checkbox!
    @IBOutlet weak var signInButton: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!

    var settingsEmbedded: SettingsEmbedded!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.GoingToProfile))
        signInButton.addGestureRecognizer(tap1)
        checkingToChangeCarrier.addTarget(self, action: #selector(self.ModifyingChecking), for: .valueChanged)
        
        let carrier = defaults.object(forKey: "carrier")
        if carrier as? Int == 1 {
            checkingToChangeCarrier.checkState = .checked
        } else {
            checkingToChangeCarrier.checkState = .unchecked
        }

    }
    
    func GoingToProfile() {
        self.performSegue(withIdentifier: "alreadySignIn", sender: self)
    }
    
    func ModifyingChecking() {
        if checkingToChangeCarrier.checkState == .unchecked {
            defaults.set(0, forKey: "carrier")
        } else if checkingToChangeCarrier.checkState == .checked {
            defaults.set(1, forKey: "carrier")
        }
    }
}

class SettingsEmbedded: UITableViewController {

    var dataArray = ["? What an overdose looks like", "? Using injectable naloxone",
                     "? Using nasal naloxone", "? Using naloxone auto-injector", "? Recovery Position"]
    var questionName: String!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : AnyObject! = storyboard.instantiateViewController(withIdentifier: "mainApplication")
            self.show(vc as! UIViewController, sender: vc)
        } else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7{
            let index = (self.tableView.indexPathForSelectedRow as IndexPath?)?.row
            questionName = dataArray[index!-3]
            self.performSegue(withIdentifier: "questionMark", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionMark"  {
            let destination = segue.destination as! QuestionMarkViewController
            destination.questionName = questionName
        }
    }
}
