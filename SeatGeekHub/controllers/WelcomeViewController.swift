//
//  WelcomeViewController.swift
//  SeatGeekHub
//
//  Created by elliott on 2/15/22.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        print("signup pressed")
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print("this is the error \(e)")
                    let alert = UIAlertController(title: "Error",
                                                  message: e.localizedDescription,
                                                  preferredStyle: .actionSheet)
                    alert.addAction((UIAlertAction(title: "OK",
                                                   style: .default,
                                                   handler: nil)))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: K.signUpSegue, sender: self)
                }
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("login pressed")
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    let alert = UIAlertController(title: "Error",
                                                  message: e.localizedDescription,
                                                  preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}
