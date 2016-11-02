//
//  ActivityHistory.swift
//  NalFind
//
//  Created by Minh Vu on 11/1/16.
//
//

import Foundation
import UIKit

class ActivityHistoryData {
    var _dateTime: String!
    var _address: String!
    var _note: String!
    
    init(dateTime: String, address: String, note: String) {
        _dateTime = dateTime
        _address = address
        _note = note
    }
    
    var description: String {
        return _dateTime + ", " + _address.components(separatedBy: ", ")[1]
    }
}

class ListActivityHistoryViewController: UIViewController {

    @IBOutlet weak var mainPage: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var activityHistoryEmbedded: ListActivityHisoryTableViewController!
    
    override func viewDidLoad() {
        settings.addTarget(self, action: #selector(self.SettingFunction), for: .touchDown)
        activityHistoryEmbedded.activityTableView.tableFooterView = UIView()
        mainPage.addTarget(self, action: #selector(self.ReturnToMainPage), for: .touchDown)
        backButton.addTarget(self, action: #selector(self.backFunction), for: .touchDown)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListActivityHisoryTableViewController {
            activityHistoryEmbedded = vc
        }
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

class ListActivityHisoryTableViewController: UITableViewController {
    @IBOutlet var activityTableView: UITableView!
    let listDateTime = ["10/20/2016", "10/21/2016","10/22/2016","10/23/2016","10/24/2016"]
    let listAddress = ["12345 SE 12th Ave, Portland OR 97202", "12233 SE 13th Ave, Portland OR 97202",
                       "12346 SE 09th Ave, Portland OR 97202", "12895 SE 10th Ave, Portland OR 98021",
                       "46547 SE 46th Ave, Portland OR 98021"]
    let listNote = ["He's good", "He needs emergency", "This is a third time, I visit him",
                    "Nothing to say", "He also needs emergency room"]
    var listOfActivityHistory = [ActivityHistoryData]()
    var listOfDescription = [String]()
    
    var activityHistoryCell = ActivityHistoryCell()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let i = (activityTableView.indexPath(for: cell)! as IndexPath).row
            let eachActivity = segue.destination as! EachActivityDataVIewController
            let activityDetails = listOfActivityHistory[i]
            eachActivity.noteText = activityDetails._note
            eachActivity.dateTimeText = activityDetails._dateTime
            eachActivity.locationText = activityDetails._address
        }
    }
    override func viewDidLoad() {
        for i in 0...4 {
            let activityHistoryData = ActivityHistoryData(dateTime: listDateTime[i]
                , address: listAddress[i], note: listNote[i])
            listOfActivityHistory.append(activityHistoryData)
            listOfDescription.append(activityHistoryData.description)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView
        , numberOfRowsInSection section: Int) -> Int{
            return listOfDescription.count
    }
    
    override func tableView(_ tableView: UITableView
        , cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        activityHistoryCell = self.tableView.dequeueReusableCell(withIdentifier: "activtityHistoryCell", for: indexPath) as! ActivityHistoryCell
        activityHistoryCell.activityHistoryCell.text = listOfDescription[(indexPath as NSIndexPath).row]
        return activityHistoryCell}
}

class ActivityHistoryCell: UITableViewCell {
    @IBOutlet weak var activityHistoryCell: UILabel!

}
