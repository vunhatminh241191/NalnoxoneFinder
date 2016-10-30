import UIKit
import Firebase

@objc(MainViewController)
class MainViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: FIRDatabaseReference!
    fileprivate var _refHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureStorage() {
        storageRef = FIRStorage.storage().reference(forURL: "gs://nalnoxone2016.appspot.com")
    }

    func sendMessage(withData data: [String: String]) {
        var mdata = data
        mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        if let photoURL = AppState.sharedInstance.photoURL {
            mdata[Constants.MessageFields.photoURL] = photoURL.absoluteString
        }
        // Push data to Firebase Database
        self.ref.child("messages").childByAutoId().setValue(mdata)
    }
    
//    @IBAction func signOut(_ sender: UIButton) {
//        let firebaseAuth = FIRAuth.auth()
//        do {
//            try firebaseAuth?.signOut()
//            AppState.sharedInstance.signedIn = false
//            dismiss(animated: true, completion: nil)
//        } catch let signOutError as NSError {
//            print ("Error signing out: \(signOutError.localizedDescription)")
//        }
//    }

}

