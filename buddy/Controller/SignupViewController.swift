//
//  SigninViewController.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var facebook: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        google.layer.cornerRadius = google.frame.size.height / 5
        facebook.layer.cornerRadius = facebook.frame.size.height / 5
    }
    
    
    @IBAction func signupPressed(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("error creating user, \(e)")
                } else{
                    self.performSegue(withIdentifier: "SignupToCode", sender: self)
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
