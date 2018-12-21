//
//  HomeViewController.swift
//  codemi
//
//  Created by Cahyanto Setya Budi on 12/20/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var qrImageView: UIImageView!
    
    var ref: DatabaseReference!
    let firebaseAuth = Auth.auth()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let userID = firebaseAuth.currentUser!.uid
        ref.child("users").child(userID).observeSingleEvent(of: .value) { (user) in
            let jsonUser = user.value as? NSDictionary
            let name = jsonUser!["name"] as? String ?? ""
            self.qrImageView.image = self.generateQRCode(from: name)
        }
    
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let transformedImage = filter?.outputImage?.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
        return UIImage(ciImage: transformedImage!)
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try firebaseAuth.signOut()
            let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginViewController, animated: true, completion: nil)
        } catch let error as NSError{
            print("Error signing out: \(error)")
        }
    }
    
}
