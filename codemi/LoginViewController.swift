//
//  LoginViewController.swift
//  codemi
//
//  Created by Cahyanto Setya Budi on 12/20/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Listen keyboard event
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text else {
            return
        }
        
        if email.isEmpty || password.isEmpty {
            showMessageAlert(title: "Error", message: "Email and password can't be empty")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (userResult, error) in
            if let error = error {
                self.showMessageAlert(title: "Error", message: error.localizedDescription)
                return
            }
            
            self.performSegue(withIdentifier: "home", sender: nil)
            return
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardSize.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showMessageAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
