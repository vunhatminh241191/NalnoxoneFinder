//
//  EachActivityData.swift
//  NalFind
//
//  Created by Minh Vu on 11/1/16.
//
//

import Foundation
import UIKit

class EachActivityDataVIewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainPage: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var location: UITextView!

    var noteText: String!
    var dateTimeText: String!
    var locationText: String!
    
    override func viewDidLoad() {
        note.text = noteText
        dateTime.text = dateTimeText
        location.text = locationText
        
        mainPage.addTarget(self, action: #selector(self.ReturnToMainPage), for: .touchDown)
        settings.addTarget(self, action: #selector(self.SettingFunction), for: .touchDown)
        backButton.addTarget(self, action: #selector(self.backFunction), for: .touchDown)
    }
    
    func SettingFunction() {
        let vc : AnyObject! = storyboard!.instantiateViewController(withIdentifier: "mainSettings")
        self.show(vc as! UIViewController, sender: vc)
    }
    
    func ReturnToMainPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : AnyObject! = storyboard.instantiateViewController(withIdentifier: "mainApplication")
        self.show(vc as! UIViewController, sender: vc)
    }
    
    func backFunction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
